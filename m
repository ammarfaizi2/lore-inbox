Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266587AbRGGVpi>; Sat, 7 Jul 2001 17:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266582AbRGGVpT>; Sat, 7 Jul 2001 17:45:19 -0400
Received: from clavin.efn.org ([206.163.176.10]:65530 "EHLO clavin.efn.org")
	by vger.kernel.org with ESMTP id <S266587AbRGGVpG>;
	Sat, 7 Jul 2001 17:45:06 -0400
From: Steve VanDevender <stevev@efn.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15175.33466.62900.43575@localhost.efn.org>
Date: Sat, 7 Jul 2001 14:44:26 -0700
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Eugene Crosser <crosser@average.org>, linux-kernel@vger.kernel.org
Subject: Re: [Acpi] Re: ACPI fundamental locking problems
In-Reply-To: <20010707233108.B10109@pcep-jamie.cern.ch>
In-Reply-To: <Pine.GSO.4.21.0107070727030.24836-100000@weyl.math.psu.edu>
	<9i73bg$psv$1@pccross.average.org>
	<3B471399.1D6BBED6@mandrakesoft.com>
	<01070719241107.22952@starship>
	<20010707233108.B10109@pcep-jamie.cern.ch>
X-Mailer: VM 6.93 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier writes:
 > (tar has a silly pad-to-multiple-of-512-byte per file rule, which is
 > inappropriate for this).

If you remember that 'tar' means "tape archiver", and that at the time
it was written the standard tape block size was 512 bytes, the rule
isn't silly at all, although it may be undesirable overhead for modern
uses of 'tar'.

