Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129072AbRBSXyK>; Mon, 19 Feb 2001 18:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129071AbRBSXyA>; Mon, 19 Feb 2001 18:54:00 -0500
Received: from paloma13.e0k.nbg-hannover.de ([62.159.219.13]:29359 "HELO
	paloma13.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S129066AbRBSXxw>; Mon, 19 Feb 2001 18:53:52 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Dieter Nützel <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: "Rik van Riel" <riel@nl.linux.org>
Subject: pmap.c : Can you please try another name for it?
Date: Tue, 20 Feb 2001 00:58:43 +0100
X-Mailer: KMail [version 1.2]
Cc: "Linux Kernel List" <linux-kernel@vger.kernel.org>,
        Andy Isaacson <adi@acm.org>
MIME-Version: 1.0
Message-Id: <01022000584300.00783@SunWave1>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rik,

there is a nice little toy called "pmap.c" around for several years, now.
Should we consider?

/*
 * pmap.c: implementation of something like Solaris' /usr/proc/bin/pmap
 * for linux
 *
 * Author: Andy Isaacson <adi@acm.org>
 * Fri Jun 18 1999
 *
 * Updated Mon Oct 25 1999
 *  - calculate total size of shared mappings
 *  - change output format to read "writable/private" rather than "writable"
 *
 * Justification:  the formatting available in /proc/<pid>/maps is less
 * than optimal.  It's hard to figure out the size of a mapping from
 * that information (unless you can do 8-digit hex arithmetic in your
 * head) and it's just generally not friendly.  Hence this utility.
 *
 * I hereby place this work in the public domain.
 *
 * Compile with something along the lines of
 * gcc -O pmap.c -o pmap
 */

Regards,
	Dieter
-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
Cognitive Systems Group
Vogt-Kölln-Straße 30
D-22527 Hamburg, Germany

email: nuetzel@kogs.informatik.uni-hamburg.de
@home: Dieter.Nuetzel@hamburg.de
