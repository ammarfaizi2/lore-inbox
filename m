Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317898AbSHGOGx>; Wed, 7 Aug 2002 10:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317946AbSHGOGx>; Wed, 7 Aug 2002 10:06:53 -0400
Received: from zeus.kernel.org ([204.152.189.113]:8873 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S317898AbSHGOGw>;
	Wed, 7 Aug 2002 10:06:52 -0400
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: NAPI (was Re: Linux 2.4.20-pre1)
References: <Pine.LNX.4.44.0208060832090.6811-100000@freak.distro.conectiva>
	<3D500364.5010607@mandrakesoft.com>
From: Marcus Sundberg <marcus@ingate.com>
Date: 07 Aug 2002 16:09:28 +0200
In-Reply-To: <3D500364.5010607@mandrakesoft.com>
Message-ID: <veofcebw13.fsf@inigo.ingate.se>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@mandrakesoft.com> writes:

> I also have a patch for sundance which fixes the issue with
> the quad port

Which issue are you referring to?
The DFE-580-doesn't-work-without-USE_IO_OPS-defined, or the
drops-packets-even-under-moderate-load? If the latter I would
be very interrested in testing that code.

//Marcus
-- 
---------------------------------------+--------------------------
  Marcus Sundberg <marcus@ingate.com>  | Firewalls with SIP & NAT
 Firewall Developer, Ingate Systems AB |  http://www.ingate.com/
