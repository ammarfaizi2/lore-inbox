Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287590AbSABNzQ>; Wed, 2 Jan 2002 08:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287612AbSABNzH>; Wed, 2 Jan 2002 08:55:07 -0500
Received: from SMTP5.ANDREW.CMU.EDU ([128.2.10.85]:22794 "EHLO
	smtp5.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id <S287590AbSABNyy>; Wed, 2 Jan 2002 08:54:54 -0500
Date: Wed, 2 Jan 2002 08:54:52 -0500 (EST)
From: Steinar Hauan <hauan@cmu.edu>
X-X-Sender: <hauan@unix12.andrew.cmu.edu>
To: "M. Edward Borasky" <znmeb@aracnet.com>
cc: <linux-kernel@vger.kernel.org>
Subject: RE: smp cputime issues
In-Reply-To: <HBEHIIBBKKNOBLMPKCBBOEBAEFAA.znmeb@aracnet.com>
Message-ID: <Pine.GSO.4.33L-022.0201020851430.1894-100000@unix12.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jan 2002, M. Edward Borasky wrote:
> The obvious question is: how do the printed *elapsed* (wall clock) times
> compare with a stopwatch timing of the same run??

sorry,

  should have included that all timings are consistent.
  (usr/sys vs reported wall clock time vs external stop watch time)

  for reference: the effect arises for a several different memory types
  (pc133, pc133 ecc, pc133 reg ecc, pc2100) and the impact is similar.
  thus if it was only a memory bandwidth issue, i would expect
  the results to depend more on the memory/chipset in question.

regards,
--
  Steinar Hauan, dept of ChemE  --  hauan@cmu.edu
  Carnegie Mellon University, Pittsburgh PA, USA

