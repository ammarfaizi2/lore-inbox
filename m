Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316684AbSFUQtC>; Fri, 21 Jun 2002 12:49:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316686AbSFUQtB>; Fri, 21 Jun 2002 12:49:01 -0400
Received: from relay2.efacec.pt ([194.65.94.163]:781 "EHLO efapo2.efacec.pt")
	by vger.kernel.org with ESMTP id <S316684AbSFUQtA>;
	Fri, 21 Jun 2002 12:49:00 -0400
Subject: 2.2 and 2.4 performance issues
From: Luis Pedro de Moura Ribeiro Pinto <luis.pinto@ent.efacec.pt>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 21 Jun 2002 17:55:55 +0100
Message-Id: <1024678560.879.27.camel@lpinto>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I was asked (i'm a company freshman) to perform some tests between
kernel versions 2.2 and 2.4, and after awhile searching i found a good
set of benchmarking tools (aim7) from Caldera linux. I've tested both
2.2.20 and 2.4.18 (preemptive patch) versions in a PIII , and used the
default benchmark mixes that already came with the suite. For my great
surprise i started having better results with kernel 2.2, only in the
DataBase test the kernel 2.4 had better results in everything . I know
this might be old news, but i'm also new to this ml. I also read Linus
explanation about the handling of the SSE2 signal stack in 2.4, my
question is... is there anymore reasons besides this one for the
performance downgrade? Are there better way to perform the test besides
using benchmark tools like this?

thanx in advance 

