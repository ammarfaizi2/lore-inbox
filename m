Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750826AbVK0DXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbVK0DXl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 22:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbVK0DXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 22:23:41 -0500
Received: from kepler.fjfi.cvut.cz ([147.32.6.11]:55178 "EHLO
	kepler.fjfi.cvut.cz") by vger.kernel.org with ESMTP
	id S1750826AbVK0DXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 22:23:40 -0500
Date: Sun, 27 Nov 2005 04:23:39 +0100 (CET)
From: Martin Drab <drab@kepler.fjfi.cvut.cz>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: PC speaker beeping on high CPU loads on an nForce2
Message-ID: <Pine.LNX.4.60.0511270409430.30055@kepler.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

on an nForce2 system (GigaByte 7NNXP) when the CPU is under heavy load 
(like during kernel compilation for instance, or any compilation of any 
bigger project, for that matter), I hear some beeps comming out of the PC 
speaker. It's like few short beeps per second for a while, then silence 
for few seconds, then a beep here and there, and again, and so on. It is 
quite strange. It happens ever since I remember (I mean in kernel 
versions of course, I have the board for about 1.5 years). I've just been 
kind of ignoring it until now. Does anybody else happen to see the same 
symptoms? What could be the cause of this. Is it something about timing? 
But how come the PC speaker gets kiced in, while it's not being used at 
all (well, at least not intentionally) for anything. Perhaps something is 
writing some ports it is not supposed to?

Martin
