Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265819AbSKTGcp>; Wed, 20 Nov 2002 01:32:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265851AbSKTGcp>; Wed, 20 Nov 2002 01:32:45 -0500
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:57081 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S265819AbSKTGco>; Wed, 20 Nov 2002 01:32:44 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15835.11826.442334.667711@wombat.chubb.wattle.id.au>
Date: Wed, 20 Nov 2002 17:39:46 +1100
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Peter Chubb <peter@chubb.wattle.id.au>, linux-kernel@vger.kernel.org
Subject: Re: rpc.mountd problem in 2.5.48
In-Reply-To: <15835.3154.178557.663327@notabene.cse.unsw.edu.au>
References: <15834.1952.674371.221691@wombat.chubb.wattle.id.au>
	<15834.49275.238123.495190@notabene.cse.unsw.edu.au>
	<15834.51557.836769.918443@wombat.chubb.wattle.id.au>
	<15835.3154.178557.663327@notabene.cse.unsw.edu.au>
X-Mailer: VM 7.04 under 21.4 (patch 10) "Military Intelligence" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Neil" == Neil Brown <neilb@cse.unsw.edu.au> writes:

Neil> On Wednesday November 20, peter@chubb.wattle.id.au wrote:
>>
Neil> I suspec that adding 'insecure' did not fix the problem, but
Neil> rather it was trying again that fixed the problem.
>> Removing `insecure' and doing exportfs -r -a brings the problem
>> back again.

Neil> Extremely odd as the presence or absense of 'insecure' cannot
Neil> (as far as I can see) affect any of the messages that you are
Neil> seeing.

Even stranger is that I can now no longer reproduce the problem.
Grrrrr.

Peter c
