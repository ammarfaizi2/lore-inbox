Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281403AbRKPNaz>; Fri, 16 Nov 2001 08:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281412AbRKPNap>; Fri, 16 Nov 2001 08:30:45 -0500
Received: from mustard.heime.net ([194.234.65.222]:57264 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S281407AbRKPNac>; Fri, 16 Nov 2001 08:30:32 -0500
Date: Fri, 16 Nov 2001 14:30:30 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: <linux-kernel@vger.kernel.org>
Subject: To Highmem or not to Highmem???
Message-ID: <Pine.LNX.4.30.0111161425190.18054-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

I just recompiled my server's kernel without highmem to test if I could
tweak a little more speed out of it that way. After booting up on the new
kernel, I do a 'free', and get the answer 'total 1238188'.

I've double-checked, double built and double-scratched-my-head...

How can this be? I thought a kernel without highmem wasn't supposed to
find any more than 960/1024MB,,,

I'm running 2.4.13-ac5+tux

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

