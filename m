Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265277AbSKSAUG>; Mon, 18 Nov 2002 19:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265305AbSKSAUG>; Mon, 18 Nov 2002 19:20:06 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57106 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265277AbSKSAUF>;
	Mon, 18 Nov 2002 19:20:05 -0500
Message-ID: <3DD98537.5080409@pobox.com>
Date: Mon, 18 Nov 2002 19:26:31 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kevin Brosius <cobra@compuserve.com>
CC: kernel <linux-kernel@vger.kernel.org>
Subject: Re: ksyms, kksymoops, modules, et.al.
References: <3DD977E6.9996A521@compuserve.com>
In-Reply-To: <3DD977E6.9996A521@compuserve.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Brosius wrote:

> So what's going on with ksyms in 2.5.48 (and bk trees since the module
> loader change, as far as I can tell)?  I no longer see /proc/ksyms and
> kernel oops's don't get decoded automatically either.



It's currently broken due to the new module code... ping Rusty for a fix ;-)

