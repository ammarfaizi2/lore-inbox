Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283320AbRLILKs>; Sun, 9 Dec 2001 06:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283316AbRLILKi>; Sun, 9 Dec 2001 06:10:38 -0500
Received: from alfik.ms.mff.cuni.cz ([195.113.19.71]:40466 "EHLO
	alfik.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S283314AbRLILKT>; Sun, 9 Dec 2001 06:10:19 -0500
Date: Sun, 9 Dec 2001 10:24:18 +0100
From: Pavel Machek <pavel@suse.cz>
To: Daniel Bergman <d-b@home.se>
Cc: Larry McVoy <lm@bitmover.com>, "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Henning Schmiedehausen <hps@intermeta.de>,
        linux-kernel@vger.kernel.org
Subject: Re: SMP/cc Cluster description
Message-ID: <20011209102417.A114@elf.ucw.cz>
In-Reply-To: <20011207080603.B6983@work.bitmover.com> <2692295916.1007714643@[10.10.1.2]> <20011207092314.F27589@work.bitmover.com> <3C1111D0.9B7E30FF@home.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C1111D0.9B7E30FF@home.se>
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > My pay job is developing a distributed source management system which works
> > by replication.  We already have users who put all the etc files in it and
> > manage them that way.  Works great.  It's like rdist except it never screws
> > up and it has merging.
> 
> I'm just curious, what about security? Is this done in clear-text? 
> Sounds dangerous to put /etc/shadow, for example, in clear-text on the
> cable.

This is going over System Area Network. You don't encrypt your PCI, either.
-- 
"I do not steal MS software. It is not worth it."
                                -- Pavel Kankovsky
