Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288859AbSAIR3g>; Wed, 9 Jan 2002 12:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288862AbSAIR32>; Wed, 9 Jan 2002 12:29:28 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:34710
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S288902AbSAIR3B>; Wed, 9 Jan 2002 12:29:01 -0500
Date: Wed, 9 Jan 2002 12:13:37 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Giacomo Catenazzi <cate@debian.org>
Cc: reddog83 <reddog83@chartermi.net>, linux-kernel@vger.kernel.org
Subject: Re: CML2-2.0.4 is available
Message-ID: <20020109121337.A23105@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Giacomo Catenazzi <cate@debian.org>,
	reddog83 <reddog83@chartermi.net>, linux-kernel@vger.kernel.org
In-Reply-To: <fa.ijumnqv.13juc98@ifi.uio.no> <fa.fvl9anv.u6q1pu@ifi.uio.no> <3C3C02E2.4050008@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C3C02E2.4050008@debian.org>; from cate@debian.org on Wed, Jan 09, 2002 at 09:44:18AM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giacomo Catenazzi <cate@debian.org>:
> Maybe better: use other keystrings. I.e. Control + key.
> In this way is more difficult to press the wrong key sequence, but we
> still have the full features in all modes.

Not a bad idea, but where possible I like to keep the ttyconfig and menuconfig
commands the same -- and ttyconfig can't easily see control characters.

Anyway this would just address a surface symptom.  The real problem is
that the deduction engine can do bad things when suppression is off.
I want to fix that.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"Experience should teach us to be most on our guard to protect liberty when the
government's purposes are beneficient...The greatest dangers to liberty lurk in
insidious encroachment by men of zeal, well meaning but without understanding."
	-- Supreme Court Justice Louis Brandeis
