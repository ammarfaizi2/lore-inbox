Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281772AbRLRPFE>; Tue, 18 Dec 2001 10:05:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281773AbRLRPEy>; Tue, 18 Dec 2001 10:04:54 -0500
Received: from ns.suse.de ([213.95.15.193]:55567 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S281772AbRLRPEu>;
	Tue, 18 Dec 2001 10:04:50 -0500
Date: Tue, 18 Dec 2001 16:04:44 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: _PepeR_ <peper@wsisiz.edu.pl>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.1 crashed during sending processes TERM signal
In-Reply-To: <Pine.LNX.4.42.0112181226460.20596-100000@oceanic.wsisiz.edu.pl>
Message-ID: <Pine.LNX.4.33.0112181604000.29077-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Dec 2001, _PepeR_ wrote:

> At shutdown the system stops at the message "Sending all precesses TERM
> signal...". The isn't any messages of possible failure in logs.
> I'm using 2.5.1 kernel. If it's matter my system is an Athlon 1GHz on ECS
> K7S5A mainboard. If you need some detailed information please contact me
> on my e-mail 'coz I'm not subscribed to lkml.

Known problem, backed out in next kernel Linus puts out.
If you're going to be playing with 2.5's, you really should consider
at least subscribing to the digests.

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

