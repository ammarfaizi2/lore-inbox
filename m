Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318434AbSGSEE5>; Fri, 19 Jul 2002 00:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318435AbSGSEE5>; Fri, 19 Jul 2002 00:04:57 -0400
Received: from bgm-24-169-49-60.stny.rr.com ([24.169.49.60]:65010 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S318434AbSGSEE4>; Fri, 19 Jul 2002 00:04:56 -0400
Date: Thu, 18 Jul 2002 23:11:52 -0400 (EDT)
From: Steven Rostedt <rostedt@stny.rr.com>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: Steven Rostedt <rostedt@stny.rr.com>
To: Giro <giro@hades.udg.es>
cc: linux-kernel@vger.kernel.org
Subject: Re: Slab.c
In-Reply-To: <Pine.LNX.4.30.0207181023360.7973-100000@hades.udg.es>
Message-ID: <Pine.LNX.4.44.0207182307400.1756-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jul 2002, Giro wrote:

> 
> that it means this?
> 
> 	Kernel Bug at slab.c:1130!
> 	after it kernel panic, dificult to debug :(
> 

goto line 1130 of mm/slab.c and that is where it crashed.

-- Steve


