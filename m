Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317191AbSGNWLs>; Sun, 14 Jul 2002 18:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317192AbSGNWLr>; Sun, 14 Jul 2002 18:11:47 -0400
Received: from moutvdomng0.kundenserver.de ([195.20.224.130]:59602 "EHLO
	moutvdomng0.schlund.de") by vger.kernel.org with ESMTP
	id <S317191AbSGNWLp>; Sun, 14 Jul 2002 18:11:45 -0400
Date: Sun, 14 Jul 2002 16:14:35 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Mathieu Chouquet-Stringer <mathieu@newview.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
In-Reply-To: <xlt1ya6j746.fsf@shookay.newview.com>
Message-ID: <Pine.LNX.4.44.0207141613440.3452-100000@hawkeye.luckynet.adm>
X-Location: Potsdam; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 14 Jul 2002, Mathieu Chouquet-Stringer wrote:
> mchouque - /tmp/joerg %/usr/bin/time tar jxf rock.tar.bz2
> 19.69user 6796.49system 1:56:05elapsed 97%CPU (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (319major+951minor)pagefaults 0swaps
> /usr/bin/time tar jxf rock.tar.bz2  19.69s user 6796.49s system 97% cpu 1:56:05.11 total

Impressive. Did the interval between file writes get longer as time 
passed?

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

