Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289139AbSAQSxw>; Thu, 17 Jan 2002 13:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290019AbSAQSxm>; Thu, 17 Jan 2002 13:53:42 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:42379
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S289139AbSAQSxi>; Thu, 17 Jan 2002 13:53:38 -0500
Date: Thu, 17 Jan 2002 14:02:16 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: Reid Hekman <reid.hekman@ndsu.nodak.edu>
Cc: kelley eicher <carde@astro.umn.edu>, linux-kernel@vger.kernel.org
Subject: Re: safest verion of gcc to use?
Message-ID: <20020117140216.A26129@animx.eu.org>
In-Reply-To: <20020117121923.A7977@astro.umn.edu> <1011292762.31205.24.camel@zeus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <1011292762.31205.24.camel@zeus>; from Reid Hekman on Thu, Jan 17, 2002 at 12:39:20PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, Documentation/Changes is more correct. For i386, 2.95.[34] and
> 2.96-[>=85] work fine. GCC 3.0.3 should work too, though some drivers
> have had difficulties and earlier 3.x releases generated some ICE's.
> Other architectures may vary.

IMO, gcc 3.0.3 shouldn't be used (atleast on alpha platforms).  I tried it
and I got nothing but ecc errors all over the console

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
