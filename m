Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312054AbSCTTbQ>; Wed, 20 Mar 2002 14:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312081AbSCTTbF>; Wed, 20 Mar 2002 14:31:05 -0500
Received: from lightning.hereintown.net ([207.196.96.3]:34976 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id <S312077AbSCTTaK>; Wed, 20 Mar 2002 14:30:10 -0500
Date: Wed, 20 Mar 2002 14:47:37 -0500 (EST)
From: Chris Meadors <clubneon@hereintown.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: task_struct changes?
Message-ID: <Pine.LNX.4.40.0203201442590.7618-100000@rc.priv.hereintown.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to update some of the code for the Alpha arch.  Seems that the
task_struct struct was changed, but the changes were not reflected in all
the platforms.

These two have nailed me so far:

task_struct->p_opptr

task_struct->p_pptr


What were they changed to, and is it just a one line fix, or is it more
involved?

-Chris
-- 
Two penguins were walking on an iceberg.  The first penguin said to the
second, "you look like you are wearing a tuxedo."  The second penguin
said, "I might be..."                         --David Lynch, Twin Peaks

