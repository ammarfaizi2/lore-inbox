Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbTFBJpT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 05:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbTFBJpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 05:45:18 -0400
Received: from 213-187-164-3.dd.nextgentel.com ([213.187.164.3]:12695 "EHLO
	exchange.Pronto.TV") by vger.kernel.org with ESMTP id S262098AbTFBJot convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 05:44:49 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [REPOST][REPOST][REPOST] Killing processes in D state
Date: Mon, 2 Jun 2003 11:58:13 +0200
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200306021158.13429.roy@karlsbakk.net>
X-OriginalArrivalTime: 02 Jun 2003 09:58:13.0779 (UTC) FILETIME=[7B514630:01C328ED]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all

this discussion has been up a few times, but I want it again. I _REALLY_ want 
to be able to kill processes in D state. I am aware of that this is not good, 
but compared to other parts of the linux kernel, there's quite a lot suicidal 
stuff there already, so why not. There is, for instance, in 2.5, the 
possibility to forcably remove loaded modules - FAR worse than merely killing 
a userspace process in D state.

So please, dear kernel people, Free Thy Users From Those Terrible Unreasonable 
Reboots.

regards

roy
-- 
Roy Sigurd Karlsbakk, Datavaktmester
ProntoTV AS - http://www.pronto.tv/
Tel: +47 9801 3356

Computers are like air conditioners.
They stop working when you open Windows.

