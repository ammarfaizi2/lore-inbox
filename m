Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132788AbRC2QmX>; Thu, 29 Mar 2001 11:42:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132787AbRC2QmN>; Thu, 29 Mar 2001 11:42:13 -0500
Received: from dfmail.f-secure.com ([194.252.6.39]:57095 "HELO
	dfmail.f-secure.com") by vger.kernel.org with SMTP
	id <S132788AbRC2Ql7>; Thu, 29 Mar 2001 11:41:59 -0500
Date: Thu, 29 Mar 2001 18:51:03 +0200 (MET DST)
From: Szabolcs Szakacsits <szaka@f-secure.com>
To: "Dr. Michael Weller" <eowmob@exp-math.uni-essen.de>
cc: Andreas Dilger <adilger@turbolinux.com>,
   Martin Dalecki <dalecki@evision-ventures.com>,
   Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
   Jonathan Morton <chromi@cyberspace.org>,
   Rogier Wolff <R.E.Wolff@bitwizard.nl>, <linux-kernel@vger.kernel.org>
Subject: Re: OOM killer???
In-Reply-To: <Pine.A32.3.95.1010329160740.63156B-100000@werner.exp-math.uni-essen.de>
Message-ID: <Pine.LNX.4.30.0103291844530.21682-100000@fs131-224.f-secure.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 29 Mar 2001, Dr. Michael Weller wrote:

> Applications forking and then dirtying their shared data pages
> madly? OOps.. nothing.. Why? It cannot be done!

In eager mode Solaris, Tru64, Irix, non-overcommit patch for Linux by
Eduardo Horvath from last year can do (you get ENOMEM at fork).

	Szaka

