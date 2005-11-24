Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932438AbVKXRBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbVKXRBP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 12:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932449AbVKXRBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 12:01:15 -0500
Received: from smtp4-g19.free.fr ([212.27.42.30]:13546 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S932438AbVKXRBO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 12:01:14 -0500
From: Duncan Sands <duncan.sands@free.fr>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Subject: Re: speedtch driver, 2.6.14.2
Date: Thu, 24 Nov 2005 18:01:09 +0100
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org
References: <200511232125.25254.s0348365@sms.ed.ac.uk>
In-Reply-To: <200511232125.25254.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511241801.10424.duncan.sands@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I recently switched from the userspace speedtouch driver to the in-kernel one. 
> However, on my rev 4.0 Speedtouch 330, I periodically get the message:
> 
> ATM dev 0: error -110 fetching device status

By the way, did you use to monitor the line using modem_run?  Did it work
(and of course: did you get any error messages?).

Ciao,

D.
