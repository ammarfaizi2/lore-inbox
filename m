Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287388AbSBIUN3>; Sat, 9 Feb 2002 15:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287111AbSBIUNR>; Sat, 9 Feb 2002 15:13:17 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:28174 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S287306AbSBIUNM>; Sat, 9 Feb 2002 15:13:12 -0500
Date: Sat, 9 Feb 2002 21:12:52 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Andreas Dilger <adilger@turbolabs.com>
Subject: Re: pull vs push (was Re: [bk patch] Make cardbus compile in -pre4)
Message-ID: <20020209201252.GD32401@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
In-Reply-To: <20020209181213.GA32401@come.alcove-fr> <Pine.LNX.4.33.0202091241080.1196-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0202091241080.1196-100000@home.transmeta.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 09, 2002 at 12:59:16PM -0800, Linus Torvalds wrote:

> Right now the "definitive" bk repository is on master.kernel.org, which
> can only be accessed by people who have accounts there.
> 
> I also push it to my private version on bkbits.net, and it is supposed to
> be automatically then pushed onwards to the public one that is at
> http://linux.bkbits.net:8080/linux-2.5, but the infrastructure for that
> isn't yet working.

Ok, understood. While waiting for a 'proper' infrastructure', maybe
a simple cron entry will do the job ? (since the bk pull from your
private tree on bkbits to the public tree on bkbits is not supposed
to ever fail or have merge errors...)

Anyway, just did a 'bk pull' once again and noticed than linux.bkbits.net
has again the latest version. Thanks! (or thanks Larry, whatever is 
more appropriate :-)).

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
