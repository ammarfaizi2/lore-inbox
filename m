Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269119AbRIGACo>; Thu, 6 Sep 2001 20:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269413AbRIGACe>; Thu, 6 Sep 2001 20:02:34 -0400
Received: from mx-outgoing.delfi.lt ([213.197.128.109]:6930 "HELO
	mx-outgoing.delfi.lt") by vger.kernel.org with SMTP
	id <S269119AbRIGACW>; Thu, 6 Sep 2001 20:02:22 -0400
Date: Fri, 7 Sep 2001 02:02:24 +0200 (EET)
From: Nerijus Baliunas <nerijus@users.sourceforge.net>
Subject: Re[2]: Basic reiserfs question
To: Hans Reiser <reiser@namesys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Disposition: INLINE
In-Reply-To: <F45bR99kQgkV07DPT1p00005d9e@hotmail.com>
 <3B97729B.1F49AACA@namesys.com>
In-Reply-To: <3B97729B.1F49AACA@namesys.com>
X-Mailer: Mahogany, 0.63 'Saugus', compiled for Linux 2.4.7 i686
Message-Id: <20010907000239.26A738F91C@mail.delfi.lt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Sep 2001 16:56:59 +0400 Hans Reiser <reiser@namesys.com> wrote:

HR> It seems that we should put something in journal replay that says:
HR> 
HR> "Warning: replaying a non-empty journal, this means that either your system
HR> crashed, or its shutdown scripts need fixing (a common distro failing at the
HR> moment)

If you think it's RedHat, you probably are wrong - I use RH with reiserfs
a long time (more than a year - 6.2, now 7.1), and never got a message about
replaying journal if system was shut down correctly.

Regards,
Nerijus


