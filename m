Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317269AbSGTBpl>; Fri, 19 Jul 2002 21:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317308AbSGTBpl>; Fri, 19 Jul 2002 21:45:41 -0400
Received: from p50887F04.dip.t-dialin.net ([80.136.127.4]:23435 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317269AbSGTBpk>; Fri, 19 Jul 2002 21:45:40 -0400
Date: Fri, 19 Jul 2002 19:48:31 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: John Levon <movement@marcelothewonderpenguin.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: kbuild - building a module/target from multiple directories
In-Reply-To: <20020720012250.GA41640@compsoc.man.ac.uk>
Message-ID: <Pine.LNX.4.44.0207191947350.3378-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 20 Jul 2002, John Levon wrote:
> It won't descend to blahstuff/ directory then

This was not the complete solution then. Of course you still have to 
descend into blahstuff this way, but you compile all the blahstuff 
together into blahstuff.o, then include that from the upper directory.

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

