Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272659AbRIGNf4>; Fri, 7 Sep 2001 09:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272661AbRIGNfq>; Fri, 7 Sep 2001 09:35:46 -0400
Received: from atmpe.omnitel.net ([194.176.32.131]:48647 "EHLO
	atmpe.omnitel.net") by vger.kernel.org with ESMTP
	id <S272659AbRIGNfc>; Fri, 7 Sep 2001 09:35:32 -0400
Message-Id: <200109071335.f87DZcI01604@atmpe.omnitel.net>
Date: Fri, 7 Sep 2001 15:35:03 +0200 (EET)
From: Nerijus Baliunas <nerijus@users.sourceforge.net>
Subject: Re[2]: Basic reiserfs question
To: Hans Reiser <reiser@namesys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Disposition: INLINE
In-Reply-To: <F45bR99kQgkV07DPT1p00005d9e@hotmail.com>
	 <3B97729B.1F49AACA@namesys.com> <20010907000239.26A738F91C@mail.delfi.lt>
 <3B987C2E.DDDDAA0D@namesys.com>
In-Reply-To: <3B987C2E.DDDDAA0D@namesys.com>
X-Mailer: Mahogany, 0.63 'Saugus', compiled for Linux 2.4.7 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Sep 2001 11:50:06 +0400 Hans Reiser <reiser@namesys.com> wrote:

HR> Nerijus Baliunas wrote:
HR> > 
HR> > On Thu, 06 Sep 2001 16:56:59 +0400 Hans Reiser <reiser@namesys.com> wrote:
HR> > 
HR> > HR> It seems that we should put something in journal replay that says:
HR> > HR>
HR> > HR> "Warning: replaying a non-empty journal, this means that either your system
HR> > HR> crashed, or its shutdown scripts need fixing (a common distro failing at the
HR> > HR> moment)
HR> > 
HR> > If you think it's RedHat, you probably are wrong - I use RH with reiserfs
HR> > a long time (more than a year - 6.2, now 7.1), and never got a message about
HR> > replaying journal if system was shut down correctly.
HR> > 
HR> I only have secondhand reports from users who patch RedHat boot scripts as
HR> described at the end of www.namesys.com/faq.html, so your statement leaves me
HR> puzzled as to whether the secondhand reports were from persons who didn't
HR> understand the boot scripts.  Comments are welcome.

I didn't patch any boot scripts at all - they are pure RH ones.

Regards,
Nerijus


