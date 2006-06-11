Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751606AbWFKPwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751606AbWFKPwn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 11:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751631AbWFKPwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 11:52:43 -0400
Received: from vbn.0050556.lodgenet.net ([216.142.194.234]:30376 "EHLO
	vbn.0050556.lodgenet.net") by vger.kernel.org with ESMTP
	id S1751054AbWFKPwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 11:52:42 -0400
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
From: Arjan van de Ven <arjan@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       adilger@clusterfs.com, torvalds@osdl.org, alex@clusterfs.com,
       ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       cmm@us.ibm.com, linux-fsdevel@vger.kernel.org
In-Reply-To: <1149885844.22124.83.camel@localhost.localdomain>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
	 <4488E1A4.20305@garzik.org> <20060609083523.GQ5964@schatzie.adilger.int>
	 <44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org>
	 <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org>
	 <m33beecntr.fsf@bzzz.home.net>
	 <Pine.LNX.4.64.0606090913390.5498@g5.osdl.org>
	 <Pine.LNX.4.64.0606090933130.5498@g5.osdl.org>
	 <20060609181020.GB5964@schatzie.adilger.int> <4489C0B8.7050400@garzik.org>
	 <20060609115936.2fdda6d0.akpm@osdl.org>
	 <1149885844.22124.83.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 11 Jun 2006 17:52:25 +0200
Message-Id: <1150041145.3131.76.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-09 at 21:44 +0100, Alan Cox wrote:
> OTOH the number of complaints about this is minimal, people want to go
> forwards in a controlled manner not backwards.

well... they want to be able to go "a little bit" backwards; say one
version of an OS (6 months). Eg the scenario that ought to work is "go
to newer version, hate it, go back". But yes that's a limited time to go
back, not the "go back to 2.2" kind of "go back".

