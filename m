Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266345AbSKGEqs>; Wed, 6 Nov 2002 23:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266347AbSKGEqs>; Wed, 6 Nov 2002 23:46:48 -0500
Received: from packet.digeo.com ([12.110.80.53]:32472 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266345AbSKGEqr>;
	Wed, 6 Nov 2002 23:46:47 -0500
Message-ID: <3DC9F1C0.70712ED4@digeo.com>
Date: Wed, 06 Nov 2002 20:53:20 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
CC: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.46-mm1: CONFIG_SHAREPTE do not work with KDE 3
References: <200211070547.00387.Dieter.Nuetzel@hamburg.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 07 Nov 2002 04:53:20.0765 (UTC) FILETIME=[98529AD0:01C28619]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dieter Nützel wrote:
> 
> When I enable shared 3rd-level pagetables between processes KDE 3.0.x and KDE
> 3.1 beta2 at least do not work.
> 

Yup.  That's a bug which happens to everyone in the world
except Dave :(

Sorry, I should have mentioned that in the release notes.  shared
pagetables are still "under development".
