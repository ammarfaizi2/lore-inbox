Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316999AbSGNSX6>; Sun, 14 Jul 2002 14:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317003AbSGNSX5>; Sun, 14 Jul 2002 14:23:57 -0400
Received: from eos.telenet-ops.be ([195.130.132.40]:3988 "EHLO
	eos.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S316999AbSGNSX4> convert rfc822-to-8bit; Sun, 14 Jul 2002 14:23:56 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Bart Verwilst <verwilst@gentoo.org>
Reply-To: verwilst@gentoo.org
To: linux-kernel@vger.kernel.org
Subject: sa2opl3 driver b0rkage?
Date: Sun, 14 Jul 2002 20:33:29 +0200
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200207142033.29721.verwilst@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello! 

I'm using kernel 2.4.19-pre7-ac2, and since i upgraded, arts (KDE's sound 
server) keeps on crashing every few minutes :o( I have an OPL3SA2 sound card.

I think the cause is this:


<snip>
Summary of changes from v2.4.18 to v2.4.19-pre1
============================================

<marcelo@plucky.distro.conectiva> (02/03/13 1.160)
	- Add tape support to cciss driver                      (Stephen Cameron)
	- Add Permedia3 fb driver                               (Romain Dolbeau)
	- meye driver update                                    (Stelian Pop)
	- opl3sa2 update                                     (Zwane Mwaikambo)   <---  
</snip>

Several KDE bugreports say the same thing, for example:

http://bugs.kde.org/db/32/32415.html

My aRts dies with the messagebox "cpu overload - aborting".

I hope this will be solved soon, so i can enjoy stable sound again :o)

Thanks in advance!

PS Please CC me your replies, since i'm not on this list.

-- 
Bart Verwilst
Gentoo Linux Developer, Release Coordinator
Gent, Belgium
