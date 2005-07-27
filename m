Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262365AbVG0PhJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262365AbVG0PhJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 11:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262333AbVG0Pej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 11:34:39 -0400
Received: from de01egw02.freescale.net ([192.88.165.103]:49351 "EHLO
	de01egw02.freescale.net") by vger.kernel.org with ESMTP
	id S262371AbVG0PdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 11:33:11 -0400
Date: Wed, 27 Jul 2005 10:32:52 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH 00/14] ppc32: Remove board ports that are no longer maintained
Message-ID: <Pine.LNX.4.61.0507271029480.12237@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following board ports are no longer maintained or have become 
obsolete:

adir
ash
beech
cedar
ep405
k2
mcpn765
menf1
oak
pcore
rainier
redwood
sm850
spd823ts

We are there for removing support for them.

- Kumar

