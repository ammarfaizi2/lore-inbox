Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290210AbSAORqH>; Tue, 15 Jan 2002 12:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290209AbSAORp7>; Tue, 15 Jan 2002 12:45:59 -0500
Received: from [66.89.142.2] ([66.89.142.2]:28218 "EHLO starship.berlin")
	by vger.kernel.org with ESMTP id <S290211AbSAORpv>;
	Tue, 15 Jan 2002 12:45:51 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Tue, 15 Jan 2002 18:49:09 +0100
X-Mailer: KMail [version 1.3.2]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0201150023040.21289-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <Pine.LNX.4.33.0201150023040.21289-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16QXhu-0000wl-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 15, 2002 06:26 am, Mark Hahn wrote:
> > than the task's float, the completion time of the schedule as a whole will be 
> > delayed.  This is no different for a computer than it is for a group of 
> > people, it is still a scheduling problem.  Delaying any random task risks 
> 
> it is quite different.  with computers, there are often STRONG benefits
> to clustering, batching, chunking, piggybacking, whatever you want to call it.

It's no different.

> it's simply not the case that eager scheduling is always optimal.

Correct, however as far as simple, useful heuristics goes, it's not so easy
to beat.  Note that I did mention resource limitations.

   "For project schedules 'earlist completion' is the name of the 
   game, within bounds of available resources."

--
Daniel
