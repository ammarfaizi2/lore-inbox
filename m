Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261920AbTCLTK6>; Wed, 12 Mar 2003 14:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261922AbTCLTK6>; Wed, 12 Mar 2003 14:10:58 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:8138 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261920AbTCLTK5>; Wed, 12 Mar 2003 14:10:57 -0500
Date: Wed, 12 Mar 2003 20:21:22 +0100
From: Martin Waitz <tali@admingilde.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch, rfc] lt-epoll ( level triggered epoll ) ...
Message-ID: <20030312192122.GA1340@admingilde.org>
Mail-Followup-To: Davide Libenzi <davidel@xmailserver.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.50.0303101139520.1922-100000@blue1.dev.mcafeelabs.com> <XFMail.20030311171056.pochini@shiny.it> <20030312180819.GB27366@admingilde.org> <Pine.LNX.4.50.0303121027560.991-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0303121027560.991-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi :)

On Wed, Mar 12, 2003 at 10:30:54AM -0800, Davide Libenzi wrote:
> > in some situations, ET simply has wrong semantics.
> 
> IMO ET has perfectly nice semantics. The fact that ppl fail to understand
> it does not make it automatically wrong. If things not understood would
> have been flagged as wrong, we would be still living in caves.

if ppl don't understand an API, it usually is flawed.

but that's not the point here, i just wanted to point out that there are
situations that are easier to solve with one or the other semantics.
and there /is/ a need for level-based events.

-- 
CU,		  / Friedrich-Alexander University Erlangen, Germany
Martin Waitz	//  [Tali on IRCnet]  [tali.home.pages.de] _________
______________/// - - - - - - - - - - - - - - - - - - - - ///
dies ist eine manuell generierte mail, sie beinhaltet    //
tippfehler und ist auch ohne grossbuchstaben gueltig.   /
			    -
Wer bereit ist, grundlegende Freiheiten aufzugeben, um sich 
kurzfristige Sicherheit zu verschaffen, der hat weder Freiheit 
noch Sicherheit verdient.            Benjamin Franklin (1706 - 1790)
