Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbTKAX03 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 18:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbTKAX02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 18:26:28 -0500
Received: from turkey.mail.pas.earthlink.net ([207.217.120.126]:65246 "EHLO
	turkey.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S261332AbTKAX01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 18:26:27 -0500
From: Richard <ratcheson@earthlink.net>
Reply-To: ratcheson@earthlink.net
To: linux-kernel@vger.kernel.org
Subject: DMA unuseable on Compaq presario 1260
Date: Sat, 1 Nov 2003 17:26:23 -0600
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311011726.23301.ratcheson@earthlink.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Compaq laptop with the OPTI 82C825 IDE chipset.  Up until 2.4.20 the 
DMA worked fine.  Beginning with 2.4.20 i get the message HDIO_SET_DMA 
FAILED: Operation not permitted each time I try to enable DMA.

Distro is SuSE 9.0 current kenel is 2.4..21-99. default

If I go back to 2.4.19 dma works fine.  

I have RTFM, maillists, etc. since April and all I can find are references to 
other systems with same problem and on in which Alan Cox says he changed 
something which broke the Toshiba.   But no fixes for my machine. I waited 
patiently for the 9.0 upgrade hoping it would be fixed but no joy.

Is there an easy fix or do I need to compile a special kernel for this one?

TIA,
Richard

