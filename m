Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312696AbSDSSEN>; Fri, 19 Apr 2002 14:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312772AbSDSSEM>; Fri, 19 Apr 2002 14:04:12 -0400
Received: from a59178.upc-a.chello.nl ([62.163.59.178]:35077 "EHLO
	www.unternet.org") by vger.kernel.org with ESMTP id <S312696AbSDSSEL>;
	Fri, 19 Apr 2002 14:04:11 -0400
Date: Fri, 19 Apr 2002 20:04:33 +0200
From: Frank de Lange <lkml-frank@unternet.org>
To: linux-kernel@vger.kernel.org
Subject: Re: severe slowdown with 2.4 series w/heavy disk access (revisited)
Message-ID: <20020419200433.C17439@unternet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To clear up some potential confusion, the problems I'm talking about are NOT
related to the (erroneous) memory-related questions in the thread I pointed at.
It is the slowdowns which bother me, not the fact that the system 'uses up all
memory' (which is a good thing (tm)). Read a bit further into the thread and
you'll end up here:

http://hypermail.spyroid.com/linux-kernel/archived/2001/week52/0309.html

quote Alan Cox: "The free behaviour is correct (free memory is wasted memory).
The delays are obviously not"

That's why I'm asking these questions. The delays should not be there, but they
are, reproducible, over many different kernels and with several filesystems.

Cheers//Frank
 [ Moving to Sweden, looking for a project/job in Västra Götaland... ] 
-- 
  WWWWW      ________________________
 ## o o\    /     Frank de Lange     \
 }#   \|   /                          \
  \ `--| _/     <Hacker for Hire>      \
   `---'  \      +31-320-252965        /
           \    frank@unternet.org    /
            `------------------------'
 [ "Omnis enim res, quae dando non deficit, dum habetur
    et non datur, nondum habetur, quomodo habenda est."  ]
