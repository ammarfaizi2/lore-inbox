Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129858AbRCCXdN>; Sat, 3 Mar 2001 18:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129860AbRCCXdD>; Sat, 3 Mar 2001 18:33:03 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:56593 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S129858AbRCCXcu>;
	Sat, 3 Mar 2001 18:32:50 -0500
To: Noah Romer <klevin@eskimo.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, netdev@oss.sgi.com,
        Linux Knernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: New net features for added performance
In-Reply-To: <Pine.SUN.3.96.1010224182145.11813A-100000@eskimo.com>
From: Jes Sorensen <jes@linuxcare.com>
Date: 04 Mar 2001 00:32:25 +0100
In-Reply-To: Noah Romer's message of "Sat, 24 Feb 2001 18:38:12 -0800 (PST)"
Message-ID: <d3vgpq1l9y.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Noah" == Noah Romer <klevin@eskimo.com> writes:

Noah> In my experience, Tx interrupt mitigation is of little
Noah> benefit. I actually saw a performance increase of ~20% when I
Noah> turned off Tx interrupt mitigation in my driver (could have been
Noah> poor implementation on my part).

You need to define performance increase here. TX interrupt coalescing
can still be a win in the systems load department.

Jes
