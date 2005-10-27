Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932244AbVJ0U6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbVJ0U6R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 16:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932246AbVJ0U6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 16:58:17 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:61363
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S932244AbVJ0U5w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 16:57:52 -0400
From: "Alejandro Bonilla" <abonilla@linuxwireless.org>
To: Marcel Holtmann <marcel@holtmann.org>, Roland Dreier <rolandd@cisco.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 4GB memory and Intel Dual-Core system
Date: Thu, 27 Oct 2005 16:57:53 -0400
Message-Id: <20051027205451.M23682@linuxwireless.org>
In-Reply-To: <1130446278.5416.10.camel@blade>
References: <1130445194.5416.3.camel@blade>  <52mzkuwuzg.fsf@cisco.com> <1130446278.5416.10.camel@blade>
X-Mailer: Open WebMail 2.40 20040816
X-OriginatingIP: 16.126.157.6 (abonilla@linuxwireless.org)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Oct 2005 22:51:18 +0200, Marcel Holtmann wrote
> Hi Roland,
> 
> >     Marcel> The BIOS and dmidecode tells me that I have 4 GB of RAM
> >     Marcel> installed and I don't have any idea where to look for
> >     Marcel> details. What information do you need to analyze this?

.....

> 
> The kernel is compiled for x86_64 and the term EM64T is correct. The
> important question is now how do I remap that memory. Loosing almost 
> a full GB of memory wasn't my plan when upgrading to 4 GB.

This is pretty much how it works. Else, purchase an Itanium system. ;-)

EM64T != IA64

.Alejandro

> 
> Regards
> 
> Marcel

