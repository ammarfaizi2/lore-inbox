Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265102AbTANTtU>; Tue, 14 Jan 2003 14:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265130AbTANTtU>; Tue, 14 Jan 2003 14:49:20 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:53162 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP
	id <S265102AbTANTtT>; Tue, 14 Jan 2003 14:49:19 -0500
Date: Tue, 14 Jan 2003 20:58:16 +0100 (CET)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Subject: timing an application
Message-ID: <Pine.LNX.4.51.0301142044400.6432@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

being inspired by some book about optimizing c++ code i decided to do
timing of functions i wrote. I am using gettimeofday to set
two timeval structs and calculate the time between them.
But the results depend heavily on the load, also i reckon that this
is an innacurate timing.

Any ideas on timing a function, or a block of code? Maybe some kernel
timers or something.

Regards,
Maciej Soltysiak

-----BEGIN GEEK CODE BLOCK-----
VERSION: 3.1
GIT/MU d-- s:- a-- C++ UL++++$ P L++++ E- W- N- K- w--- O! M- V- PS+ PE++
Y+ PGP- t+ 5-- X+ R tv- b DI+ D---- G e++>+++ h! y?
-----END GEEK CODE BLOCK-----
