Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbTHSVrV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 17:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbTHSVrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 17:47:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1202 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261675AbTHSVrS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 17:47:18 -0400
Message-ID: <3F429ADA.1050402@pobox.com>
Date: Tue, 19 Aug 2003 17:47:06 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: rob@landley.net
CC: Erik Andersen <andersen@codepoet.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Will uclibc be supported in 2.6? (was Re: [PATCH] Re: [PATCH]
 scsi.h uses "u8" which isn't defined.)
References: <lRjc.6o4.3@gated-at.bofh.it> <200308190832.24744.rob@landley.net> <20030819172651.GA15781@gtf.org> <200308191738.36574.rob@landley.net>
In-Reply-To: <200308191738.36574.rob@landley.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:
> I'm all for doing it in 2.7.  I just want to know what I should do for 2.6.  
> If there's a consensus that we're talking about 2.7 and allowing ad-hockery 
> to continue in 2.6, I'll shut up. :)


That's always been the consensus :)

2.6 is long past the point for major header surgery and breakage.

	Jeff



