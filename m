Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132045AbRDCOvV>; Tue, 3 Apr 2001 10:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132127AbRDCOvL>; Tue, 3 Apr 2001 10:51:11 -0400
Received: from smtpnotes.altec.com ([209.149.164.10]:40714 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S132045AbRDCOu4>; Tue, 3 Apr 2001 10:50:56 -0400
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
cc: Andries.Brouwer@cwi.nl, torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk,
        hpa@transmeta.com, linux-kernel@vger.kernel.org, tytso@MIT.EDU
Message-ID: <86256A23.00517DBD.00@smtpnotes.altec.com>
Date: Tue, 3 Apr 2001 09:48:53 -0500
Subject: Re: Larger dev_t
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de> wrote:

>Yes: Let "mknod /dev/foo [bc] x y" die!

I hope this never happens.  Improving the major/minor device scheme is
reasonable; abandoning it would be a sad occurrence.  It would make Linux too
"un-UNIXish"  (how's THAT for an an ugly neologism!) for my tastes.

Wayne


