Return-Path: <linux-kernel-owner+w=401wt.eu-S1030353AbWLTUxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030353AbWLTUxi (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 15:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030356AbWLTUxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 15:53:37 -0500
Received: from gw.goop.org ([64.81.55.164]:59101 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030353AbWLTUxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 15:53:36 -0500
Message-ID: <4589A2CD.2020108@goop.org>
Date: Wed, 20 Dec 2006 12:53:33 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Frederik Deweerdt <deweerdt@free.fr>
CC: Andrew Morton <akpm@osdl.org>,
       "Andrew J. Barr" <andrew.james.barr@gmail.com>,
       linux-kernel@vger.kernel.org, Jan Beulich <jbeulich@novell.com>,
       Andi Kleen <ak@suse.de>, "Eric W. Biederman" <ebiederm@xmission.com>,
       walt <w41ter@gmail.com>
Subject: Re: [-mm patch] ptrace: Fix EFL_OFFSET value according to i386 pda
 changes (was Re: BUG on 2.6.20-rc1 when using gdb)
References: <1166406918.17143.5.camel@r51.oakcourt.dyndns.org> <20061219164214.4bc92d77.akpm@osdl.org> <45891CD1.4050506@goop.org> <20061220183521.GA28900@slug> <45898D4E.1030507@goop.org> <20061220204226.GB28900@slug>
In-Reply-To: <20061220204226.GB28900@slug>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frederik Deweerdt wrote:
> It works too, thanks. BTW, I wondered if the "case GS:" in getreg() made
> sense now?

Sorry, what do you mean?  It looks OK to me, but I'm not sure what
you're referring to.

    J
