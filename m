Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316856AbSGXFWD>; Wed, 24 Jul 2002 01:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316899AbSGXFWD>; Wed, 24 Jul 2002 01:22:03 -0400
Received: from moutvdom.kundenserver.de ([195.20.224.131]:54478 "EHLO
	moutvdomng1.kundenserver.de") by vger.kernel.org with ESMTP
	id <S316856AbSGXFWC>; Wed, 24 Jul 2002 01:22:02 -0400
Date: Tue, 23 Jul 2002 23:25:06 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Linus Torvalds <torvalds@transmeta.com>
cc: Neil Brown <neilb@cse.unsw.edu.au>, <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: type safe(r) list_entry repacement: generic_out_cast
In-Reply-To: <Pine.LNX.4.44.0207230918090.5645-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0207232324440.3200-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 23 Jul 2002, Linus Torvalds wrote:
> Maybe "member_to_container()" would be even better?

That sounds like trashing the member...

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

