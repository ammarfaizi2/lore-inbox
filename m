Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262636AbSJ0Uyr>; Sun, 27 Oct 2002 15:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262646AbSJ0Uyr>; Sun, 27 Oct 2002 15:54:47 -0500
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:40602 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S262636AbSJ0Uyq> convert rfc822-to-8bit; Sun, 27 Oct 2002 15:54:46 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
To: linux-kernel@vger.kernel.org
Subject: ARGH!  (Is there an HTML archive for linux-kernel that patches work from?)
Date: Sun, 27 Oct 2002 11:01:01 -0500
User-Agent: KMail/1.4.3
Cc: Erich Focht <efocht@ess.nec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210271001.01798.landley@trommello.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc.theaimsgroup.com has a lovely "raw mode", but it truncates posts that are 
too long.

groups.google.com looses attachments, even plain text ones.

Anything based on hypermail screws up whitespace in an interesting way.  (You 
can't "save as" because it inserts <br> between each line, even the source 
preserves whitespace and keeps tabs as tabs and everything.  You can't cut 
and paste because html that isn't quoted with <pre> mangles whitespace for 
you.  You can't make a simple script to remove <br> when it occurs at the end 
of the line because it's not consistent: blank lines don't become <br>, they 
become <p>.  And you'd have to worry about &lt; and such anyway...

I'm sorry, I'm a bit frustrated right now.  I"m trying to provide URLs to 
patches posted on this list.  This sounds easy, doesn't it?  It's not.

I'm going to go to lunch now...

Erich: Could you put your october 25 numa scheduler posting on your home page 
somewhere?  I tried:

http://home.arcor.de/efocht/patches/01-numa_sched_core-2.5.44-10a.patch

But that just would have been too easy... :)

-- 
http://penguicon.sf.net - Terry Pratchett, Eric Raymond, Pete Abrams, Illiad, 
CmdrTaco, liquid nitrogen ice cream, and caffienated jello.  Well why not?
