Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313501AbSDUQNL>; Sun, 21 Apr 2002 12:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313500AbSDUQNK>; Sun, 21 Apr 2002 12:13:10 -0400
Received: from mustard.heime.net ([194.234.65.222]:26318 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S313508AbSDUQNJ>; Sun, 21 Apr 2002 12:13:09 -0400
Date: Sun, 21 Apr 2002 18:11:44 +0200 (CEST)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
X-X-Sender: roy@mustard.heime.net
To: Dan Kegel <dank@kegel.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: re: CONFIG_RAMFS in 2.4.19-pre7-ac2 ???    
In-Reply-To: <3CC1A1EF.AF524412@kegel.com>
Message-ID: <Pine.LNX.4.44.0204211811210.17194-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Apr 2002, Dan Kegel wrote:

> Roy wrote:
> > After upgrading to 2.4.19-pre7-ac2, I can't get CONFIG_RAMFS
> 
> Gee, I hope CONFIG_RAMFS isn't going away.  I need it to
> do loopback mounts of cramfs on an embedded system that
> uses tmpfs as its main filesystem.  (tmpfs doesn't support
> loopback mounts.)

I beleive it's there by default after -pre7, but somehow it doesn't work

-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.

