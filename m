Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261815AbSI2Vqp>; Sun, 29 Sep 2002 17:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261816AbSI2Vqo>; Sun, 29 Sep 2002 17:46:44 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:19716 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S261815AbSI2Vqn>; Sun, 29 Sep 2002 17:46:43 -0400
Date: Sun, 29 Sep 2002 23:52:04 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: v2.6 vs v3.0
Message-ID: <20020929215204.GG12928@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0209281826050.2198-100000@home.transmeta.com> <200209290716.g8T7GNwf000562@darkstar.example.net> <20020929091229.GA1014@suse.de> <1033311400.13001.5.camel@irongate.swansea.linux.org.uk> <20020929153817.GC1014@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20020929153817.GC1014@suse.de>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Sep 2002, Jens Axboe wrote:

> SCSI drivers can be a real problem. Not the porting of them, most of
> that is _trivial_ and can be done as we enter 3.0-pre and people show up
> running that on hardware that actually needs to be ported. The worst bit
> is error handling, this I view as the only problem.

And a long-standing one. This should have been fixed in 2.2, it has not
been fixed in 2.4, it's much desired for 2.6 -- and people are going to
point away from Linux (and expect Jörg Schilling speaking up again
should 2.6 be released with what he considers broken API -- I cannot
tell if all his items are right, but if a third of what he says is true,
Linux SCSI is not in good shape).

