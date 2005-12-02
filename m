Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbVLBQqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbVLBQqV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 11:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbVLBQqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 11:46:21 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:65239 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750821AbVLBQqU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 11:46:20 -0500
From: Duncan Sands <duncan.sands@free.fr>
To: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: speedtch driver, 2.6.14.2
Date: Fri, 2 Dec 2005 17:46:18 +0100
User-Agent: KMail/1.9
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org
References: <200511232125.25254.s0348365@sms.ed.ac.uk> <200512010859.19905.duncan.sands@free.fr> <m3u0ds7so0.fsf@defiant.localdomain>
In-Reply-To: <m3u0ds7so0.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512021746.18870.duncan.sands@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

> Dec  1 15:20:47 defiant kernel: ATM dev 0: speedtch_check_status entered
> Dec  1 15:20:51 defiant kernel: usb 1-1: events/0 timed out on ep0in len=0/4
> Dec  1 15:20:51 defiant kernel: ATM dev 0: speedtch_read_status: MSG D failed
> Dec  1 15:20:51 defiant kernel: ATM dev 0: error -110 fetching device status

by an amazing coincidence, exactly the same thing happened to me yesterday.  I
had plugged and unplugged the phone line several times during the day, so maybe
I will be able to reproduce it at will.

Ciao,

Duncan.
