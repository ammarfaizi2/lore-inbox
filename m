Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280029AbRKSEry>; Sun, 18 Nov 2001 23:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281735AbRKSEro>; Sun, 18 Nov 2001 23:47:44 -0500
Received: from brimstone.ucr.edu ([138.23.89.35]:43012 "EHLO brimstone.ucr.edu")
	by vger.kernel.org with ESMTP id <S280029AbRKSErc>;
	Sun, 18 Nov 2001 23:47:32 -0500
Date: Sun, 18 Nov 2001 20:47:29 -0800
To: linux-kernel@vger.kernel.org
Cc: Keith Humphreys <keith@cs.ucr.edu>, johannes@brimstone.UCR.EDU
Subject: [OT] Need Very High Speed/Large Storage Space Linux Box
Message-ID: <20011118204729.A5067@infomine.ucr.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
From: Johannes Ruscheinski <ruschein@brimstone.UCR.EDU>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My research group is looking to implement a Linux 2.4.15pre6+ based system
with the following requirement:
2GB RAM, 800GB-1TB raid disk storage (ext3?).  We need good disk throughput and
have around $10,000 to spend.  Dual Athlons would be great but if there is no
highly reliable solution with Athlons we might also consider P4's.  We would
like to be able to upgrade our system in the future and CPU speed is not nearly
as important to as as disk throughput.  We are working on a publicly funded Web
search engine project that will be released under the GPL sometime next year
(we are about 70% into this and have very exciting and promising results, i.e.
we'll probably get quite a bit more money).  We are also considering spending
more money and doubling the disk space in order to mirror the custom database 
that we want to store on this monster.  Unfortunately we have to make a very
quick decision.  Stability is very important on this project.  I am one of the
developers on the project and may also do the system administration on it as
well.
Please help if you have any experience with a beast of a similar nature.
-- 
TIA,
Johannes
--
Dr. Johannes Ruscheinski
Infomine Lead Programmer                    ***              LINUX,             ***
EMail:    ruschein@infomine_no_spam.ucr.edu ***                                 ***
Location: science library, room G40         *** The Choice Of A GNU Generation! ***

*************************************************************
<a href="http://freeskylarov.org/">Free Dimitri Skylarov!</a>
*************************************************************
