Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316545AbSGYRzF>; Thu, 25 Jul 2002 13:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316592AbSGYRzF>; Thu, 25 Jul 2002 13:55:05 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:527 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S316545AbSGYRzE>; Thu, 25 Jul 2002 13:55:04 -0400
Date: Thu, 25 Jul 2002 14:57:54 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Alexander Viro <viro@math.psu.edu>
Cc: Anton Altaparmakov <aia21@cantab.net>,
       Linus Torvalds <torvalds@transmeta.com>, <Matt_Domsch@Dell.com>,
       <Andries.Brouwer@cwi.nl>, <linux-kernel@vger.kernel.org>
Subject: RE: 2.5.28 and partitions
In-Reply-To: <Pine.GSO.4.21.0207251245530.17621-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.44L.0207251457180.8815-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jul 2002, Alexander Viro wrote:
> On Thu, 25 Jul 2002, Anton Altaparmakov wrote:
> > At 12:44 25/07/02, Alexander Viro wrote:

> > It's one database, and it's huge.
>
> ... and backups of your database are done on...?

LVM snapshot + rsync to an identical machine elsewhere ?

Rik
-- 
	http://www.linuxsymposium.org/2002/
"You're one of those condescending OLS attendants"
"Here's a nickle kid.  Go buy yourself a real t-shirt"

http://www.surriel.com/		http://distro.conectiva.com/

