Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261523AbSJAISA>; Tue, 1 Oct 2002 04:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261525AbSJAISA>; Tue, 1 Oct 2002 04:18:00 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:30592 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S261523AbSJAIR7>;
	Tue, 1 Oct 2002 04:17:59 -0400
Date: Tue, 1 Oct 2002 03:23:27 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.5.40 - and a feature freeze reminder
In-Reply-To: <anbkud$q5e$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44.0210010318090.1429-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Oct 2002, Linus Torvalds wrote:

> But from what we've seen lately, there really aren't reports of
> corrupted disks or anything like that that I've seen.  Which is
> obviously not to say that it couldn't happen, but it's not a very likely
> occurrence. 

I'll echo what Linus says, FWIW.  I'm carrying several ide-related 
problems on my problem report status page 
(http://members.cox.net/tmolina/kernprobs/status.html)
but they are all related to different bits loading/unloading incorrectly.  
I've not seen a single report of data corruption on the 2.4-ac forward ported ide 
code.  

