Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261650AbUCFLMO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 06:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261655AbUCFLMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 06:12:14 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:3712 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261650AbUCFLML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 06:12:11 -0500
Date: Sat, 6 Mar 2004 11:13:17 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200403061113.i26BDHrs000517@81-2-122-30.bradfords.org.uk>
To: Timothy Miller <miller@techsource.com>, root@chaos.analogic.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4048CC7F.4070009@techsource.com>
References: <4048B36E.8000605@techsource.com>
 <Pine.LNX.4.53.0403051253220.32349@chaos>
 <4048CC7F.4070009@techsource.com>
Subject: Re: kernel 'simulator' and wave-form analysis tool?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I must have been unclear.  I was not suggesting adding hardware.  I was 
> suggesting that we could run Linux under Bochs, which is a software x86 
> emulator.  Being what it is, hooks can be added to track "cpu activity" 
> is it occurs within the emulator.  This is all a simulation.  The key 
> idea I was suggesting was to log processor activity (of the emulator) 
> and develop a viewer program which would help people visualize the activity.

Doesn't Valgrind already do most of what you want?

John.
