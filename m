Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272713AbRHaOmm>; Fri, 31 Aug 2001 10:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272714AbRHaOmc>; Fri, 31 Aug 2001 10:42:32 -0400
Received: from mailgate5.cinetic.de ([217.72.192.165]:11937 "EHLO
	mailgate5.cinetic.de") by vger.kernel.org with ESMTP
	id <S272713AbRHaOmT>; Fri, 31 Aug 2001 10:42:19 -0400
Date: Fri, 31 Aug 2001 16:03:16 +0200 (CEST)
From: Pascal Schmidt <pleasure.and.pain@web.de>
To: Thiago Vinhas de Moraes <tvlists@networx.com.br>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.9-ac1/2/3 allows multiple mounts of NFS filesystem on same
 mountpoint
In-Reply-To: <200108310122.f7V1Mas12778@jupter.networx.com.br>
Message-ID: <Pine.LNX.4.33.0108311602310.1039-100000@neptune.sol.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2001, Thiago Vinhas de Moraes wrote:

> I think it should be reinstated. We must have in mind, that currently, the
> most part of end-users are newbies, and if we want Linux to be a true Desktop
> Enviroment, we must allow people that do not want to understand it, to run it.
Couldn't this be implemented in mount instead of the kernel? Should be
easy to check /proc/mounts whether anything is already mounted on a given
mountpoint.

-- 
Ciao, Pascal

-<[ pharao90@tzi.de, netmail 2:241/215.72, home http://cobol.cjb.net/) ]>-

