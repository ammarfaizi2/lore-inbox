Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131136AbRAQCRa>; Tue, 16 Jan 2001 21:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131403AbRAQCRU>; Tue, 16 Jan 2001 21:17:20 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:6922 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S131136AbRAQCRP>;
	Tue, 16 Jan 2001 21:17:15 -0500
To: Shawn Starr <Shawn.Starr@Home.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compiling 2.4.1-preX series
In-Reply-To: <3A64F6E0.778F5734@Home.net>
From: Jes Sorensen <jes@linuxcare.com>
Date: 17 Jan 2001 03:17:06 +0100
In-Reply-To: Shawn Starr's message of "Tue, 16 Jan 2001 20:35:29 -0500"
Message-ID: <d3bst6kjml.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Shawn" == Shawn Starr <Shawn.Starr@Home.net> writes:

Shawn> Which compiler will compile the 2.4.1-preX series? Since 2.4.0,
Shawn> my GCC 2.95.2 patched with PGCC 2.95.3 (which creates
Shawn> pgcc-2.95.2) refuses to compile any versions after this. Which
Shawn> is the next stable and binary compatable compiler?

Shawn> Anyone have any suggestions? I dont wish to use the development
Shawn> GCC 2.96/2.97 because they will break my binary compatability
Shawn> with pgcc-2.95.2/3.

Yes, it's simple you want the real gcc 2.96/2.97 or egcs-1.1.2. pgcc
is not supported.

Jes
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
