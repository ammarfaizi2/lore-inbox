Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288957AbSAFOO7>; Sun, 6 Jan 2002 09:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288958AbSAFOOt>; Sun, 6 Jan 2002 09:14:49 -0500
Received: from raven.ecs.soton.ac.uk ([152.78.70.1]:30352 "EHLO
	raven.ecs.soton.ac.uk") by vger.kernel.org with ESMTP
	id <S288957AbSAFOOm>; Sun, 6 Jan 2002 09:14:42 -0500
Date: Sun, 6 Jan 2002 14:14:30 +0000 (GMT)
From: Marcin Tustin <mt500@ecs.soton.ac.uk>
X-X-Sender: <mt500@localhost.localdomain>
To: <linux-kernel@vger.kernel.org>
Subject: Whizzy New Feature: Paged segmented memory
Message-ID: <Pine.LNX.4.33.0201061408540.7398-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-ECS-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Any comments on how useful it would be to have paged, segmented,
memory support for Pentium? I was thinking that by having separate
segments for text, stack, and heap, buffer overrun exploits would be
eliminated (I'm aware that this would require GCC patching as well).
	Obviously, I'm thinking that I (and any similar fools I could rope
in) would try this (Probably delivering for a kernel at least a year out
of date by the time we had a patch).


Sorry
if this is too userspace.

