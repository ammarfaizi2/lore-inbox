Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265368AbSK1Jqx>; Thu, 28 Nov 2002 04:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265369AbSK1Jqx>; Thu, 28 Nov 2002 04:46:53 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:5905 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S265368AbSK1Jqw>; Thu, 28 Nov 2002 04:46:52 -0500
Message-ID: <3DE5E7DC.8F688E0E@aitel.hist.no>
Date: Thu, 28 Nov 2002 10:54:36 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.49 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: Verifying Kernel source
References: <20021127092818.Q24374@work.bitmover.com> <Pine.GSO.4.21.0211272326350.5044-100000@vervain.sonytel.be> <20021127183009.G9443@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:

> > > If it's in BK you can be pretty sure that it is what was checked in,
> > > BK checksums every diff in every file.  It's not at all impossible
> > > to fool the checksum but it is very unlikely that you can cause
> > > semantic differences in the form of a trojan horse and still fool
> > > the checksums.

> The bottom line is that, so far, the BK tree is safe. 

Sure, it is hard to _fake_ bk, but how about someone cracking
a machine?  Couldn't they check in a trojan using
the normal check-in procedures?  

Helge Hafting
