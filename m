Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316540AbSFULvJ>; Fri, 21 Jun 2002 07:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316573AbSFULvI>; Fri, 21 Jun 2002 07:51:08 -0400
Received: from lukoil.lt ([212.59.17.210]:21487 "HELO lukoil.lt")
	by vger.kernel.org with SMTP id <S316540AbSFULvI>;
	Fri, 21 Jun 2002 07:51:08 -0400
Message-ID: <009701c21919$eceae8d0$4c00000a@lukoil.lt>
From: "Egidijus Antanaitis" <e.antanaitis@lukoil.lt>
To: <linux-kernel@vger.kernel.org>
References: <3D1300D1.8020903@bonin.ca> <20020621115216.GA4687@router.zwanebloem.xs4all.nl>
Subject: Strange problems with 2.4.18 on RH 7.2
Date: Fri, 21 Jun 2002 13:51:05 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Linux RH 7.2, vanilla kernel 2.4.18 with SGI XFS patch 1.1. The test: I
have tried to copy a large file (700MB) from one disk to another and the
effect: after copying for 2 seconds, it stops for 2 seconds and again again
and again... The same situation with vanilla without XFS patch. The problem
dissapears when I use RH's prepared kernel. The friend of mine reports the
same. Where is the point?

Egidijus Antanaitis


