Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbUCPThH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 14:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbUCPTcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 14:32:43 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32733 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261351AbUCPTcQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 14:32:16 -0500
Message-ID: <40575631.1080006@pobox.com>
Date: Tue, 16 Mar 2004 14:32:01 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk, bos@serpentine.com,
       linux-raid@vger.kernel.org
Subject: Re: [PATCH] klibc update
References: <4056B0DB.9020008@pobox.com> <20040316005229.53e08c0c.akpm@osdl.org> <20040316153719.GA13723@kroah.com> <20040316111026.6729e153.akpm@osdl.org> <40575279.7040408@pobox.com> <20040316192458.GB21172@kroah.com>
In-Reply-To: <20040316192458.GB21172@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Tue, Mar 16, 2004 at 02:16:09PM -0500, Jeff Garzik wrote:
> 
>>Bryan O'Sullivan and Greg KH at varying times in the past had BK trees, 
>>but I didn't know of any up-to-date one.
> 
> 
> I think Bryan was trying to keep his bk tree up to date with the klibc
> cvs tree, but don't know how well that went.

The latest I found from bos was 2.6.0-test9, not terribly ancient but 
still required some hand-fixing of merge conflicts.


>>Note that it isn't my intention to become klibc maintainer...  just in 
>>case anybody started getting ideas... :)
> 
> 
> I thought hpa was the klibc maintainer, you're just offering a patch to
> add it to the build :)

Right...  I meant I am not going to become the maintainer of said 
patch/BK tree :)

	Jeff




