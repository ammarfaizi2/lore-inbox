Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261527AbSJWADP>; Tue, 22 Oct 2002 20:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261596AbSJWADP>; Tue, 22 Oct 2002 20:03:15 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:59374 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S261527AbSJWADP>; Tue, 22 Oct 2002 20:03:15 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15797.59564.331886.37542@wombat.chubb.wattle.id.au>
Date: Wed, 23 Oct 2002 10:09:16 +1000
To: Jesse Pollard <pollard@admin.navo.hpc.mil>
Cc: Tim Hockin <thockin@sun.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH 1/4] fix NGROUPS hard limit (resend)
In-Reply-To: <354127220@toto.iv>
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jesse" == Jesse Pollard <pollard@admin.navo.hpc.mil> writes:

Jesse> On Tuesday 22 October 2002 12:37 pm, Tim Hockin wrote:

Jesse> And I really doubt that anybody has 10000 unique groups (or
Jesse> even close to that) running under any system. The center I'm at

well... if you put each user in his or her own group, the total number
of unique groups gets pretty big pretty fast.  

That doesn't mean, however, that one needs to be in thousands of
groups simultaneously.

Peter C
