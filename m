Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129747AbRBQMgz>; Sat, 17 Feb 2001 07:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129136AbRBQMgp>; Sat, 17 Feb 2001 07:36:45 -0500
Received: from beamer.mchh.siemens.de ([194.138.158.163]:2737 "EHLO
	beamer.mchh.siemens.de") by vger.kernel.org with ESMTP
	id <S129781AbRBQMgf>; Sat, 17 Feb 2001 07:36:35 -0500
From: "Thomas Widmann" <thomas.widmann@icn.siemens.de>
To: <linux-kernel@vger.kernel.org>
Subject: SMP: bind process to cpu
Date: Sat, 17 Feb 2001 13:36:33 +0100
Message-ID: <BGEDIODHBENLENEMBEPAEEDFCAAA.thomas.widmann@icn.siemens.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I run an 3*XEON 550MHz Primergy with 2GB of RAM.
On this machine, i have compiled kernel 2.4.0SMP.

Is it possible to bind a process to a specific
cpu on this SMP machine (process affinity) ?

I there something like pset ?

Thanks in advance

Regards
Widmann Thomas
Siemens AG - Munich
