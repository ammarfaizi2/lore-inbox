Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261667AbSJMTha>; Sun, 13 Oct 2002 15:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261668AbSJMTha>; Sun, 13 Oct 2002 15:37:30 -0400
Received: from 2-225.ctame701-1.telepar.net.br ([200.193.160.225]:36794 "EHLO
	2-225.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S261667AbSJMTha>; Sun, 13 Oct 2002 15:37:30 -0400
Date: Sun, 13 Oct 2002 17:42:55 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: "Joseph D. Wagner" <wagnerjd@prodigy.net>
cc: "'David S. Miller'" <davem@redhat.com>, <robm@fastmail.fm>,
       <hahn@physics.mcmaster.ca>, <linux-kernel@vger.kernel.org>,
       <jhoward@fastmail.fm>
Subject: RE: Strange load spikes on 2.4.19 kernel
In-Reply-To: <000f01c27294$438d5fa0$7443f4d1@joe>
Message-ID: <Pine.LNX.4.44L.0210131742330.22735-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Oct 2002, Joseph D. Wagner wrote:

> Prove it.  If you can code multi-threading SMP block and inode
> allocation using a non-preemptive kernel (which Linux is) ON THE SAME
> PARTITION, I will eat my hard drive.

Try the XFS patch.

Do you prefer ketchup or mustard ?

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://distro.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

