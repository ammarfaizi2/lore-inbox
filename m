Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbVH2X5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbVH2X5m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 19:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbVH2X5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 19:57:42 -0400
Received: from 62-43-0-251.user.ono.com ([62.43.0.251]:56201 "EHLO
	antoli.gallimedina.net") by vger.kernel.org with ESMTP
	id S932087AbVH2X5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 19:57:41 -0400
From: Ricardo Galli <gallir@uib.es>
Organization: UIB
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.13
Date: Tue, 30 Aug 2005 01:57:27 +0200
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508300157.27347.gallir@uib.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There it is.

2.6.13 does not boot in my PPC (iBook, 500 MHz), it hangs just at the very 
begining and the machines is automatically rebooted after a couple of 
minutes.

The on-screen messages finishes with a few "openpic" messages: 
http://mnm.uib.es/gallir/tmp/linux-13-ppc.jpg

I used the same 2.5.12's .config that works fine 
(http://mnm.uib.es/gallir/tmp/config-2.6.13-ppc.txt). During "make oldconfig" 
I selected the default options, with the exception of the "hardware monitor" 
which I first enabled and then disabled because was the first suspicious.

Can I do any further test? Or is it a stupid mistake?


Cheers.

-- 
  ricardo galli       GPG id C8114D34
  http://mnm.uib.es/gallir/
