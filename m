Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751097AbVJSQop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbVJSQop (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 12:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbVJSQop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 12:44:45 -0400
Received: from www.tuxrocks.com ([64.62.190.123]:29444 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S1751097AbVJSQoo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 12:44:44 -0400
Message-ID: <435677DE.9010805@tuxrocks.com>
Date: Wed, 19 Oct 2005 10:44:14 -0600
From: Frank Sorenson <frank@tuxrocks.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: Ktimer / -rt9 (+custom) monotonic_clock going backwards.
References: <Pine.LNX.4.58.0510191047270.24515@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.58.0510191047270.24515@localhost.localdomain>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Steven Rostedt wrote:
> 358.069795728 secs then later 355.981483177.  Should this ever happen?

Pretty sure that "NO" is the correct answer :)

> FYI, the system is UP. And I compiled without CONFIG_KTIME_SCALAR.

What sort of CPU?  Does it have frequency scaling?

Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFDVnfeaI0dwg4A47wRAomrAKDN6y1AsA1P3jhTqBcNHmrSc18pVQCgu9Fh
AGO6q8+agAmlP9jIDXVxgOs=
=Nn7R
-----END PGP SIGNATURE-----
