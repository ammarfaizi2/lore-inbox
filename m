Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261972AbVCHKnX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261972AbVCHKnX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 05:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261971AbVCHKmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 05:42:37 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:14219 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261967AbVCHKmc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 05:42:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=tHwSWvzCPXKkkpk9eXoJ8F78knygF1VgjpxzjFl5hsI7X9xrVyTgUnsirW/CE7tpo1lSklMSm9DjGMsNrN3ekoMM359tL0dI75b6CKyg/F21RFE9j26CXGluoD7FSD4WfXDRWl69rGiJ2YTQILbQ+esHpj796iZVfqIHxk/suQ0=
Message-ID: <58cb370e050308024214400e1f@mail.gmail.com>
Date: Tue, 8 Mar 2005 11:42:30 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] resync ATI PCI idents into base kernel
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1110276929.28860.93.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200503072216.j27MGxtP024504@hera.kernel.org>
	 <20050308053941.GA16450@kroah.com>
	 <1110276929.28860.93.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Mar 2005 10:15:30 +0000, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > Was there a reason you did this without using tabs, like the rest of the
> > file?
> 
> No but I'll send Linus an update to fix that now.
> 
> > Again, the maintainer chain is well documented...
> 
> Really - so does it go to the PCI maintainer, the IDE maintainer or the
> DRI maintainer or someone else, or all of them, or in bits to different
> ones remembering there are dependancies and I don't use bitcreeper ?

it should go to /dev/null because there are no users of these IDs ;-)
