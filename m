Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129674AbQKJQiF>; Fri, 10 Nov 2000 11:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129687AbQKJQh4>; Fri, 10 Nov 2000 11:37:56 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:9955 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129674AbQKJQhj>; Fri, 10 Nov 2000 11:37:39 -0500
From: Christoph Rohland <cr@sap.com>
To: "Theodore Y. Ts'o" <tytso@MIT.EDU>
Cc: richardj_moore@uk.ibm.com, Paul Jakma <paulj@itg.ie>,
        Michael Rothwell <rothwell@holly-springs.nc.us>,
        linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Generalised Kernel Hooks Interface (GKHI)
In-Reply-To: <200011101624.LAA22004@tsx-prime.MIT.EDU>
Organisation: SAP LinuxLab
Date: 10 Nov 2000 17:37:28 +0100
In-Reply-To: "Theodore Y. Ts'o"'s message of "Fri, 10 Nov 2000 11:24:28 -0500"
Message-ID: <qww7l6bpyuv.fsf@sap.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Theodore,

On Fri, 10 Nov 2000, Theodore Y. Ts'o wrote:
> P.S.  There are some such RAS features which I wouldn't be surprised
> there being interest in having integrated into the kernel directly
> post-2.4, with no need to put in "kernel hooks" for that particular
> feature.  A good example of that would be kernel crash dumps.  For
> all Linux houses which are doing support of customers remotely,
> being able to get a crash dump so that developers can investigate a
> problem remotely instead of having to fly a developer out to the
> customer site is invaluable.  In fact, it might be considerd more
> valuable than the kernel debugger....

*Yes* :-)

Greetings
		Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
