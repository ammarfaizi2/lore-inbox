Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318492AbSGSJcq>; Fri, 19 Jul 2002 05:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318493AbSGSJcq>; Fri, 19 Jul 2002 05:32:46 -0400
Received: from p50887DBB.dip.t-dialin.net ([80.136.125.187]:47749 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318492AbSGSJcp>; Fri, 19 Jul 2002 05:32:45 -0400
Date: Fri, 19 Jul 2002 03:35:03 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Andrea Arcangeli <andrea@suse.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andre Hedrick <andre@linux-ide.org>
Subject: Re: Severe problems with 2.4.19-rc2-aa1 on k6-II
In-Reply-To: <20020719112528.B15517@oldwotan.suse.de>
Message-ID: <Pine.LNX.4.44.0207190333350.3378-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 19 Jul 2002, Andrea Arcangeli wrote:
> > 2. Mouse and keyboard are both on one port. Now if I load gpm, the whole 
> > PS/2 controller gets stuck until I unplug both mouse and keyboard and then 
> > re-plug them. It all worked fine ever before.

Fair enough, from the moment I sent this mail (2) never happened again. 
However, the IDE mis-probing is still present, and reproducible with any 
2.4.18+ kernel.

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------

