Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261225AbVCZSnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbVCZSnl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 13:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbVCZSnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 13:43:41 -0500
Received: from services.blue4.cz ([212.158.157.202]:58060 "HELO smtp.blue4.cz")
	by vger.kernel.org with SMTP id S261225AbVCZSni convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 13:43:38 -0500
From: Milan Svoboda <milan.svoboda@centrum.cz>
To: Greg KH <gregkh@suse.de>
Subject: Re: kernel oops, 2.6.11.3
Date: Sat, 26 Mar 2005 18:27:03 +0100
User-Agent: KMail/1.8
References: <200503182103.59649.milan.svoboda@centrum.cz> <20050318223004.GA18675@kroah.com>
In-Reply-To: <20050318223004.GA18675@kroah.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200503261827.03359.milan.svoboda@centrum.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dne pátek 18 bøezen 2005 23:30 jste napsal(a):
> On Fri, Mar 18, 2005 at 09:03:59PM +0100, Milan Svoboda wrote:
> > Hello,
> >
> > usbnet (iPAQ with Familiar) and harddisk connected throught usb were in
> > use during this oops.
> >
> > HW: HP Omnibook xt6200
>
> Does this happen with preempt disabled?
>

yes, it does and it is worst.

But I find out that my harddisk contains some bad sectors and I suspect that  
my swap partitions contains some of them :-( 

> thanks,
>
> greg k-h

Milan Svoboda
