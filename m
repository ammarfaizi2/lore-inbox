Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312381AbSCUQDj>; Thu, 21 Mar 2002 11:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312383AbSCUQDa>; Thu, 21 Mar 2002 11:03:30 -0500
Received: from lightning.hereintown.net ([207.196.96.3]:24535 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id <S312381AbSCUQDW>; Thu, 21 Mar 2002 11:03:22 -0500
Date: Thu, 21 Mar 2002 11:20:50 -0500 (EST)
From: Chris Meadors <clubneon@hereintown.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: When was sched_task_migrated removed?
Message-ID: <Pine.LNX.4.40.0203211112020.7618-100000@rc.priv.hereintown.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does anyone know off hand what patch removed sched_task_migrated from
<linux/sched.h>?

It didn't apply the needed changes to the Alpha, PPC64, or x86_64
platforms.

-Chris
-- 
Two penguins were walking on an iceberg.  The first penguin said to the
second, "you look like you are wearing a tuxedo."  The second penguin
said, "I might be..."                         --David Lynch, Twin Peaks

