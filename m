Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbTJXJZZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 05:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbTJXJZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 05:25:25 -0400
Received: from indigo.cs.bgu.ac.il ([132.72.42.23]:38355 "EHLO
	indigo.cs.bgu.ac.il") by vger.kernel.org with ESMTP id S262119AbTJXJZY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 05:25:24 -0400
Date: Fri, 24 Oct 2003 11:26:34 +0200 (IST)
From: Nir Tzachar <tzachar@cs.bgu.ac.il>
To: Daniel Egger <degger@fhm.edu>
cc: Eric Sandall <eric@sandall.us>, <linux-kernel@vger.kernel.org>
Subject: Re: srfs - a new file system.
In-Reply-To: <1066907220.1686.22.camel@sonja>
Message-ID: <Pine.LNX.4.44.0310241122260.4770-100000@lvs-rs3.cs.bgu.ac.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The last time I looked Coda was a horrible mess of a code, closely
> impossible to get it compile let alone configure and it seems to have
> the same interoperability problems like intermezzo i.e. it didn't work
> between i386<->powerpc. I haven't looked at Lustre light or srfs yet but
> I certainly welcome any fresh projects in the area of distributed or
> replicating filesystems.

well, i hope u'll take a look at our file system, but keep in mind:
a) the code is in an early beta state.
b) srfs _cheats_ a bit, by enslaving a local file system.
c) the code is not as neat as i'd like it to be.
d) we havnt checked interoperability, since we dont have other platform.
   although, srfs should work on any platform running java.

cheers.
-- 
========================================================================
nir.

