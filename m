Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264746AbSJaIhX>; Thu, 31 Oct 2002 03:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264782AbSJaIgY>; Thu, 31 Oct 2002 03:36:24 -0500
Received: from mailout07.sul.t-online.com ([194.25.134.83]:18326 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S264779AbSJaIgE> convert rfc822-to-8bit; Thu, 31 Oct 2002 03:36:04 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: WOLK - Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] v2.2.22-2-secure // [PATCH | PATCHSET | FULLKERNEL]
Date: Thu, 31 Oct 2002 09:42:26 +0100
User-Agent: KMail/1.4.3
Cc: Roberto Nibali <ratz@drugphish.ch>
References: <200210310057.24743.m.c.p@wolk-project.de> <3DC0DA57.7040900@drugphish.ch>
In-Reply-To: <3DC0DA57.7040900@drugphish.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210310942.26843.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 31 October 2002 08:23, Roberto Nibali wrote:

Hi Roberto,

> > Changes in v2.2.22-1-secure
> > ---------------------------
> > o  add:      Port/Socket Pseudo ACLs v2.2.21-14
> > o  add:      VM buffer tuning
> > o  add:      Etherdivert
> > o  add:      802.1d Ethernet Bridging v1.02
> > o  add:      Firewall for the ethernet bridge, using ipchains v1.02
> > o  add:      IPsec masquerading with IPVS
>
> How can you have such a code in the 2.2.x kernel when we're not even
> finished with its 2.5.x implementation in LVS? If you took the code from
> ipvs-1.1.0 and backported it, I would believe it, but I doubt this is
> possible. Care to clarify this entry?
args, you are right. Awfull typo :-( ... What I meant was:

http://www.impsec.org/linux/masquerade/ip_masq_vpn.html

Thnx for pointing!

-- 
Kind regards
        Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/569DE2E3DB441A16
Fingerprint: 3469 0CF8 CA7E 0042 7824 080A 569D E2E3 DB44 1A16
Key available at www.keyserver.net. Encrypted e-mail preferred.
