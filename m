Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317500AbSGEQym>; Fri, 5 Jul 2002 12:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317503AbSGEQyl>; Fri, 5 Jul 2002 12:54:41 -0400
Received: from moutvdomng0.kundenserver.de ([195.20.224.130]:233 "EHLO
	moutvdomng0.schlund.de") by vger.kernel.org with ESMTP
	id <S317500AbSGEQyk>; Fri, 5 Jul 2002 12:54:40 -0400
Date: Fri, 5 Jul 2002 10:57:01 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Daniel Egger <degger@fhm.edu>
cc: Anton Altaparmakov <aia21@cantab.net>,
       Thunder from the hill <thunder@ngforever.de>, <venom@sns.it>,
       <linux-kernel@vger.kernel.org>
Subject: Re: IBM Desktar disk problem?
In-Reply-To: <1025883147.17269.24.camel@sonja.de.interearth.com>
Message-ID: <Pine.LNX.4.44.0207051053120.10105-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5 Jul 2002, Daniel Egger wrote:
> Though the timespan makes me curious: Why is there a magnitude
> difference in runtime between the first problem on a fresh drive
> and after a lowlevel format?

Can be anything. The disk's administration parts getting messed up with 
crap, and already having got messed up by some test run right after 
production. Or maybe the drives were padded with maintainer data before 
they were shipped (means, after production).

Imagine it thermodynamically. A half-ordered system keeps getting messed 
up. Somewhen it's messed up. If you order your system it will take longer 
for the drive to get messed up.

Maybe the part which failed in the old firmware was some garbage 
collection code? Something that removes the crap?

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

