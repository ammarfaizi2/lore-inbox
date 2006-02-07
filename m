Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965079AbWBGNow@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965079AbWBGNow (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 08:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965081AbWBGNow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 08:44:52 -0500
Received: from CPE-24-31-249-53.kc.res.rr.com ([24.31.249.53]:46271 "EHLO
	tsurukikun.utopios.org") by vger.kernel.org with ESMTP
	id S965079AbWBGNov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 08:44:51 -0500
From: Luke-Jr <luke@dashjr.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
Date: Tue, 7 Feb 2006 13:44:59 +0000
User-Agent: KMail/1.9
Cc: davids@webmaster.com,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
References: <MDEHLPKNGKAHNMBLJOLKGECCJPAB.davids@webmaster.com> <50968728-E8BA-46BB-83D9-866ADEE546DA@mac.com>
In-Reply-To: <50968728-E8BA-46BB-83D9-866ADEE546DA@mac.com>
Public-GPG-Key: 0xD53E9583
Public-GPG-Key-URI: http://dashjr.org/~luke-jr/myself/Luke-Jr.pgp
IM-Address: luke-jr@jabber.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602071345.00627.luke@dashjr.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 February 2006 22:38, Kyle Moffett wrote:
> On Feb 06, 2006, at 16:07, David Schwartz wrote:
> >> The LGPL deals with only derivative works. The GPL also deals with
> >> mere *linking*. If glibc were GPL'd, it would be illegal to make
> >> an OS based on it with a single C program incompatible with the GPL.
> >
> > The only way the GPL can control work Y because it affects work Z
> > is because Y is a derivative work of work Z. If it's not, then the
> > works are legally unrelated, and no matter what the GPL says, it
> > can't affect work Y.
>
> To say this more simplistically, the LGPL essentially says "Even if
> dynamic linking constitutes making a derivative work, we allow you to
> dynamically link, so long as the rules are followed for the LGPL code
> to which you link".  The GPL essentially says "If dynamic linking is
> making a derivative work, then these rules apply to the whole
> derivative work and all of its constituent parts".

Does the "if" clause exist? If not, then by distributing the original 
software, the distributor is agreeing to abide by the GPL terms for anything 
linking with it. If the linking code is not GPL-compatible, the distributor 
cannot legally distribute the GPL'd component.

> Whether or not an NVidia binary module is a derivative work is left
> up to the courts to decide.  It _may_ be legal (don't trust me,
> consult your lawyer) to have a very simple cross-platform interface
> and some BSD-licensed glue. 

They might have a legal loophole if dynamic linking doesn't constitute a 
derivative work *and* nVidia doesn't distribute Linux (thus does not need to 
agree to GPL terms).
