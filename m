Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318794AbSHGSUg>; Wed, 7 Aug 2002 14:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318796AbSHGSUg>; Wed, 7 Aug 2002 14:20:36 -0400
Received: from mailgw3a.lmco.com ([192.35.35.7]:49678 "EHLO mailgw3a.lmco.com")
	by vger.kernel.org with ESMTP id <S318794AbSHGSUL>;
	Wed, 7 Aug 2002 14:20:11 -0400
Content-return: allowed
Date: Wed, 07 Aug 2002 14:22:05 -0400
From: "Reed, Timothy A" <timothy.a.reed@lmco.com>
Subject: Hyperthreading Options in 2.4.19
To: "Linux Kernel ML (E-mail)" <linux-kernel@vger.kernel.org>
Message-id: <9EFD49E2FB59D411AABA0008C7E675C009D8DEE3@emss04m10.ems.lmco.com>
MIME-version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,
	I am going rounds with a sub-contractor of ours about what options
should and should not be compiled into the kernel in order for
Hyperthreading to work.  Can anyone make any suggestions and comments to the
options (below)  that I am planning on enforcing:
	MSR
	MTRR
	CPUID

	Lilo.conf : acpismp=force?? 

	Are the following worth any thing of value to Hyperthreading:
	Microcode
	ACPI

TIA

Timothy Reed
Software Engineer/Systems Administrator
Lockheed Martin - NE & SS Syracuse
Email: timothy.a.reed@lmco.com

