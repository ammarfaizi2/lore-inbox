Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263108AbTJKQeT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 12:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263131AbTJKQeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 12:34:19 -0400
Received: from mtaw4.prodigy.net ([64.164.98.52]:9109 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S263108AbTJKQeR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 12:34:17 -0400
Message-ID: <3F8830DF.6060803@pacbell.net>
Date: Sat, 11 Oct 2003 09:33:35 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: dbrownell@users.sourceforge.net, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.4 patch] add USB gadget Configure help entries
References: <20031011120508.GU24300@fs.tum.de>
In-Reply-To: <20031011120508.GU24300@fs.tum.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> In 2.4.23-pre7 USB gadget support was added but no Configure.help 
> entries were added.
> 
> The patch below adds these missing entries. the help texts were copied 
> from 2.6, please check whether they are correct for 2.4, too.

They look right to me -- thanks!

- Dave



