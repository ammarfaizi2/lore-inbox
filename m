Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132271AbQLHQo3>; Fri, 8 Dec 2000 11:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132301AbQLHQoT>; Fri, 8 Dec 2000 11:44:19 -0500
Received: from mx1.hcvlny.cv.net ([167.206.112.76]:20700 "EHLO
	mx1.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S132271AbQLHQoD>; Fri, 8 Dec 2000 11:44:03 -0500
To: "Barry Smoke" <bsmoke@bryant.dsc.k12.ar.us>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: rage 128 mobility m/p and kernel DRI
In-Reply-To: <IMEKIDMFAEBICGFFGJPKAENDCPAA.bsmoke@bryant.k12.ar.us>
From: Alan Shutko <ats@acm.org>
Date: 08 Dec 2000 11:08:08 -0500
In-Reply-To: <IMEKIDMFAEBICGFFGJPKAENDCPAA.bsmoke@bryant.k12.ar.us>
Message-ID: <87lmtq28wn.fsf@wesley.springies.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.0.92
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Barry Smoke" <bsmoke@bryant.dsc.k12.ar.us> writes:

> DRI is available for the rage 128, but it is not working on this chipset.

[...]

> Windows reports the chip as a rage mobility-p agp 1x, agp2x

That's not a Rage Mobility 128, I believe.  That's a Mach-64-based
chip.  Check /var/log/XFree86.0.log for a line like

(--) Chipset ATI Rage 128 Mobility LF (AGP) found

-- 
Alan Shutko <ats@acm.org> - In a variety of flavors!
A 'full' life in my experience is usually full only of other people's demands.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
