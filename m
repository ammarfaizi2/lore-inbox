Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282237AbRKWUmD>; Fri, 23 Nov 2001 15:42:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282235AbRKWUlx>; Fri, 23 Nov 2001 15:41:53 -0500
Received: from fluent1.pyramid.net ([206.100.220.212]:57400 "EHLO
	fluent1.pyramid.net") by vger.kernel.org with ESMTP
	id <S282237AbRKWUlo>; Fri, 23 Nov 2001 15:41:44 -0500
Message-Id: <4.3.2.7.2.20011123123635.00bf8980@mail.fluent-access.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Fri, 23 Nov 2001 12:41:41 -0800
To: linux-kernel@vger.kernel.org
From: Stephen Satchell <satch@fluent2.pyramid.net>
Subject: Tools to check for config-dependent symbol sets?
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Before I start thinking how to design a tool to deal with 
highly-configurable software like the Linux kernel, I thought I'd ask 
first.  Does anyone know of any tools to determine if a symbol is undefined 
or multiply-defined for a given combination of <n> configuration variables 
without having to actually perform 2**n compilations?

Satch

