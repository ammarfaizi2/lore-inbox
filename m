Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266443AbTA2QoI>; Wed, 29 Jan 2003 11:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266478AbTA2QoI>; Wed, 29 Jan 2003 11:44:08 -0500
Received: from aloggw.analogic.com ([204.178.40.2]:8201 "EHLO
	aloggw.analogic.com") by vger.kernel.org with ESMTP
	id <S266443AbTA2QoH>; Wed, 29 Jan 2003 11:44:07 -0500
Message-ID: <61C1E83D9DA9D311A871009027D617F0017DE6A1@PEAEXCH1>
From: "Pocrovsky, Lev" <LPocrovsky@analogic.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "Pocrovsky, Lev" <LPocrovsky@analogic.com>
Subject: .align help
Date: Wed, 29 Jan 2003 11:53:22 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody,

I am building up a library using xmm and mmx registers in Linux environment.
At the begin of this activity I was given a sample routine,  which contains
a line

.align   16

in a text segment.
As far as I can understand the line of the sort does not have any sense and
GCC-compiler must ignore it. Nevertheless I noticed by running test programs
that unpredictably some times the line does impact on execution time,
sometimes it does not.

Any explanation ?

Thanks, Lev
