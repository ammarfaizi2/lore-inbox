Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161277AbWAMMQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161277AbWAMMQA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 07:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932715AbWAMMQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 07:16:00 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:47542 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S932713AbWAMMQA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 07:16:00 -0500
From: Duncan Sands <duncan.sands@free.fr>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Subject: Re: speedtch driver, 2.6.14.2
Date: Fri, 13 Jan 2006 13:15:55 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <200511232125.25254.s0348365@sms.ed.ac.uk>
In-Reply-To: <200511232125.25254.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601131315.55355.duncan.sands@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I recently switched from the userspace speedtouch driver to the in-kernel one. 
> However, on my rev 4.0 Speedtouch 330, I periodically get the message:
> 
> ATM dev 0: error -110 fetching device status

Is this correlated with disk activity (heavy use of the pci bus)?

Thanks,

Duncan.
