Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262958AbSJFWyC>; Sun, 6 Oct 2002 18:54:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262961AbSJFWyB>; Sun, 6 Oct 2002 18:54:01 -0400
Received: from 2-225.ctame701-1.telepar.net.br ([200.193.160.225]:18083 "EHLO
	2-225.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S262958AbSJFWx7>; Sun, 6 Oct 2002 18:53:59 -0400
Date: Sun, 6 Oct 2002 19:59:33 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Aaron Lehmann <aaronl@vitelus.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: New BK License Problem?
In-Reply-To: <20021006224511.GC9785@vitelus.com>
Message-ID: <Pine.LNX.4.44L.0210061958490.22735-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Oct 2002, Aaron Lehmann wrote:

> On Sun, Oct 06, 2002 at 07:33:55PM -0300, Rik van Riel wrote:
> > The following command should work:
> >
> > 	rsync -rav --delete nl.linux.org::kernel/linux-2.4 linux-2.4
>
> Note that -a implies -r. You also might want -z in there depending how
> your availability of bandwidth and CPU cycles compare.

The way things are now, nl.linux.org has more bandwidth than
CPU.  Using -z is a good idea though, if you've got more CPU
than bandwith.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

