Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261547AbRF0N4e>; Wed, 27 Jun 2001 09:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261881AbRF0N4Y>; Wed, 27 Jun 2001 09:56:24 -0400
Received: from athena.intergrafix.net ([206.245.154.69]:33696 "HELO
	athena.intergrafix.net") by vger.kernel.org with SMTP
	id <S261547AbRF0N4H>; Wed, 27 Jun 2001 09:56:07 -0400
Date: Wed, 27 Jun 2001 09:56:06 -0400 (EDT)
From: Admin Mailing Lists <mlist@intergrafix.net>
To: David Wagner <daw@mozart.cs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] User chroot
In-Reply-To: <9hbage$djn$1@abraham.cs.berkeley.edu>
Message-ID: <Pine.LNX.4.10.10106270954410.29607-100000@athena.intergrafix.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 27 Jun 2001, David Wagner wrote:
> 
> Why is it useless?  It sounds useful to me, on first glance.  If I want
> to run a user-level network daemon I don't trust (for instance, fingerd),
> isolating it in a chroot area sounds pretty nice: If there is a buffer
> overrun in the daemon, you can get some protection [*] against the rest
> of your system being trashed.  Am I missing something obvious?
> 

if you don't mind running fingerd on a non-privleged (>1024) port.

-Tony
.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-.
Anthony J. Biacco                       Network Administrator/Engineer
thelittleprince@asteroid-b612.org       Intergrafix Internet Services

    "Dream as if you'll live forever, live as if you'll die today"
http://www.asteroid-b612.org                http://www.intergrafix.net
.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-.

