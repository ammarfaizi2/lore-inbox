Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317637AbSGUE7K>; Sun, 21 Jul 2002 00:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317639AbSGUE7K>; Sun, 21 Jul 2002 00:59:10 -0400
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:35136 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S317637AbSGUE7J>; Sun, 21 Jul 2002 00:59:09 -0400
Date: Sat, 20 Jul 2002 23:02:13 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: David Caplan <david@polycode.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Asus-a7v/Via-Vt8233 data corruption
In-Reply-To: <20020721043653.NLID8251.tomts6-srv.bellnexxia.net@david>
Message-ID: <Pine.LNX.4.44.0207202300180.3309-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 21 Jul 2002, David Caplan wrote:
> Assersion Failure in __journal_file_buffer() transaction.c:1937

That means nothing but incorrect locking, I guess. What else do we assert 
there? FWIW, line 1937 is empty...

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

