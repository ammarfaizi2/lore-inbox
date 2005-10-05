Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030449AbVJEXq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030449AbVJEXq7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 19:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030450AbVJEXq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 19:46:59 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:24024 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030449AbVJEXq7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 19:46:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jVg35rMtxxMgrjZEmr2uRv4DL+IMV7H2PcolLOhihny8FmpCxMnjy6lKUe+53Bl0SFzUhnKvcdn6UXDNVm+szdS/yZnenHgdYK3sj7quMTdSW0Vz0LCB25i6kt3zD7AwptNyH8EdJ4d+L4yctbVAlWLHM+l8f9YcEtvq+vadxHo=
Message-ID: <21d7e9970510051646q4074813cwfa843e6ad1b7ce44@mail.gmail.com>
Date: Thu, 6 Oct 2005 09:46:57 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: jmerkey <jmerkey@utah-nac.org>
Subject: Re: Why no XML in the Kernel?
Cc: Nix <nix@esperi.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <43445238.5030900@utah-nac.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051002094142.65022.qmail@web51012.mail.yahoo.com>
	 <87oe66r62s.fsf@amaterasu.srvr.nix>
	 <20051003153515.GW7992@ftp.linux.org.uk>
	 <87zmpqbcws.fsf@amaterasu.srvr.nix>
	 <21d7e9970510051411y2f2871a7mafa2e96cce277657@mail.gmail.com>
	 <87br23odls.fsf@amaterasu.srvr.nix>
	 <21d7e9970510051557u42ae32f0rca46e951c5da536f@mail.gmail.com>
	 <8764sbwoj7.fsf@amaterasu.srvr.nix>
	 <21d7e9970510051636g29012748o77124c1c1abc9259@mail.gmail.com>
	 <43445238.5030900@utah-nac.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> How about putting the ability to disable graphics mode in the kernel and
> moving this capability from X, and saving the video state. Would make
> kernel debuggers work a hell of a lot better when the damn thing crashes
> in X in the kernel. At least then the screen won;t be locked up (of
> course you can type "reboot " from memory while the system is still hung
> in X).
>

It's been on the todo list for a long while... there's been talks at
different events about it, there'll be a talk at LCA from me again
about it and what has happened since KS (not a huge amount)....

We've nearly all agreed on a direction, we haven't found anyone with
the bandwidth to actually move things in that direction... (or at
least no-one has said to me heres some money  go do this thing... :-)

Dave.
