Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265042AbSJPPFL>; Wed, 16 Oct 2002 11:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265043AbSJPPFL>; Wed, 16 Oct 2002 11:05:11 -0400
Received: from mailgw3a.lmco.com ([192.35.35.7]:35338 "EHLO mailgw3a.lmco.com")
	by vger.kernel.org with ESMTP id <S265042AbSJPPFJ>;
	Wed, 16 Oct 2002 11:05:09 -0400
Content-return: allowed
Date: Wed, 16 Oct 2002 11:03:43 -0400
From: "Reed, Timothy A" <timothy.a.reed@lmco.com>
Subject: HZ impact
To: "Linux Kernel ML (E-mail)" <linux-kernel@vger.kernel.org>,
       "Reed, Timothy A" <timothy.a.reed@lmco.com>
Cc: "Lindke, Chad" <chad.lindke@lmco.com>
Message-id: <9EFD49E2FB59D411AABA0008C7E675C009D8E039@emss04m10.ems.lmco.com>
MIME-version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mornin' All,
	Quick question, what is the impact good/bad of changing the HZ value
from 100 to 1000 in the asm-i386/param.h?  Besides the fact that it is 10
times larger.

TIA

Timothy Reed
Software Engineer \ Systems Administrator
Lockheed Martin - NE & SS Syracuse
Email: timothy.a.reed@lmco.com

