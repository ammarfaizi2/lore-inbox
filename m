Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266126AbRF2RTa>; Fri, 29 Jun 2001 13:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266125AbRF2RTU>; Fri, 29 Jun 2001 13:19:20 -0400
Received: from zmsvr04.tais.net ([12.106.80.12]:36621 "EHLO zmsvr04.tais.net")
	by vger.kernel.org with ESMTP id <S266123AbRF2RTI>;
	Fri, 29 Jun 2001 13:19:08 -0400
Subject: Linux Sparc V9 code optimazation
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF01E29F0A.A587033D-ON88256A7A.005E7998@tais.net>
From: Ramil.Santamaria@tais.toshiba.com
Date: Fri, 29 Jun 2001 10:20:29 -0700
X-MIMETrack: Serialize by Router on zmsvr04/tais_external(Release 5.0.6a |January 17, 2001) at
 06/29/2001 10:19:08 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To any Sparc guru,

This question relates to the effect of instruction alignment on a Sparc's
Prefetch/Dispatch unit.

Just how exactly does the branch prediction bits for instruction pairs in
the I-Cache utilized.

I'm trying to figure out the consequences of an odd word fetch into an
Instruction cache line with a the fourth
instruction being another branch.

Please cc me as I am currently not on the mailing list.

Ramil J.Santamaria
Toshiba America Information Systems
(949) 461-4379
(949) 206-3439 - fax
ramil.santamaria@tais.toshiba.com

