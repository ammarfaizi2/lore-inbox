Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317658AbSGOVgG>; Mon, 15 Jul 2002 17:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317657AbSGOVgF>; Mon, 15 Jul 2002 17:36:05 -0400
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:17480 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S317658AbSGOVfo>; Mon, 15 Jul 2002 17:35:44 -0400
Date: Mon, 15 Jul 2002 15:38:37 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: "Patrick J. LoPresti" <patl@curl.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
In-Reply-To: <s5g7kjwsn12.fsf@egghead.curl.com>
Message-ID: <Pine.LNX.4.44.0207151537360.3452-100000@hawkeye.luckynet.adm>
X-Location: Canberra; Australia
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 15 Jul 2002, Patrick J. LoPresti wrote:
> Note that this means writing a truly reliable shell or Perl script is
> tricky.  I suppose you can "use POSIX qw(fsync);" in Perl.  But what do
> you do for a shell script?  /bin/sync :-) ?

Write a binary (/usr/bin/fsync) which opens a fd, fsync it, close it, be 
done with it.

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------

