Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262208AbUCODY3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 22:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262211AbUCODY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 22:24:29 -0500
Received: from sbcs.cs.sunysb.edu ([130.245.1.15]:9142 "EHLO
	sbcs.cs.sunysb.edu") by vger.kernel.org with ESMTP id S262208AbUCODYR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 22:24:17 -0500
Date: Sun, 14 Mar 2004 22:22:37 -0500 (EST)
From: Nishant Nagalia <ninagal@cs.sunysb.edu>
X-X-Sender: ninagal@compserv2
To: linux-kernel@vger.kernel.org
Subject: Interrupts
Message-ID: <Pine.GSO.4.53.0403142216500.18610@compserv2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am trying to modify linux scheduler for my project.

I want to schedule interrupts whenever I want,means I want to queue
an interrupt when it comes and execute it when my scheduler will want it
to. I should be able to queue it before it executes any function/ISR
inside kernel and then schedule it when required.

I am not able to find proper documentation of how exactly I can do this. I
would really appreciate if anyone can help me in this regards.

Nishant.
