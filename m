Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262120AbTJXJ1q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 05:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbTJXJ1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 05:27:46 -0400
Received: from indigo.cs.bgu.ac.il ([132.72.42.23]:51155 "EHLO
	indigo.cs.bgu.ac.il") by vger.kernel.org with ESMTP id S262120AbTJXJ1m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 05:27:42 -0400
Date: Fri, 24 Oct 2003 11:28:54 +0200 (IST)
From: Nir Tzachar <tzachar@cs.bgu.ac.il>
To: Pavel Machek <pavel@ucw.cz>
cc: Eric Sandall <eric@sandall.us>, <linux-fsdevel@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: srfs - a new file system.
In-Reply-To: <20031023135850.GF643@openzaurus.ucw.cz>
Message-ID: <Pine.LNX.4.44.0310241127100.4770-100000@lvs-rs3.cs.bgu.ac.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

> Yes, but perhaps differences can be localized to userspace daemon,
> having same kernel part for coda and srfs?
> That would be *good*.
> 

in essence, ur correct. we would have taken that approach, if we were not 
aiming at building a file system on top of an object storage. this 
approach simplifies things a bit, and the kernel part is reduced.

-- 
========================================================================
nir.

