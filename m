Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319414AbSILCgq>; Wed, 11 Sep 2002 22:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319415AbSILCgq>; Wed, 11 Sep 2002 22:36:46 -0400
Received: from [64.6.248.2] ([64.6.248.2]:62881 "EHLO greenie.frogspace.net")
	by vger.kernel.org with ESMTP id <S319414AbSILCgq>;
	Wed, 11 Sep 2002 22:36:46 -0400
Date: Wed, 11 Sep 2002 19:41:25 -0700 (PDT)
From: cogwepeter@greenie.frogspace.net
To: linux-kernel@vger.kernel.org
Subject: 2.4.19-ac4 Out of Memory
In-Reply-To: <Pine.LNX.4.44.0209042038490.13193-100000@greenie.frogspace.net>
Message-ID: <Pine.LNX.4.44.0209111934280.11402-100000@greenie.frogspace.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greetings --

I was using mplayer on an i686 2.4.19-ac4 just now, and it suddenly froze.  
That is to say, it wasn't entirely frozen -- if you moved the mouse and
waited ten seconds, the cursor would move. Accessing it from another
terminal (one that was already logged in), I could type at the rate of a
letter a minute. After a few minutes it resolved itself and came back to
normal.

/var/log/messages showed this:

kernel: Out of Memory: Killed process 9702 (gmplayer).

I've not encountered this in 2.4.16.

Cheers,
Peter

