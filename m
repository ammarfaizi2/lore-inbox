Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261839AbTCLR5q>; Wed, 12 Mar 2003 12:57:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261840AbTCLR5q>; Wed, 12 Mar 2003 12:57:46 -0500
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:26347 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S261839AbTCLR5p>; Wed, 12 Mar 2003 12:57:45 -0500
Date: Wed, 12 Mar 2003 19:08:19 +0100
From: Martin Waitz <tali@admingilde.org>
To: Giuliano Pochini <pochini@shiny.it>
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch, rfc] lt-epoll ( level triggered epoll ) ...
Message-ID: <20030312180819.GB27366@admingilde.org>
Mail-Followup-To: Giuliano Pochini <pochini@shiny.it>,
	Davide Libenzi <davidel@xmailserver.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.50.0303101139520.1922-100000@blue1.dev.mcafeelabs.com> <XFMail.20030311171056.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <XFMail.20030311171056.pochini@shiny.it>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 11, 2003 at 05:10:56PM +0100, Giuliano Pochini wrote:
> If ET il faster than LT, tell people to stop whining and to learn
> the API. Otherwise choose LT, mainly because of 2), but also
> because ET API is more subtle bug prone.

in some situations, ET simply has wrong semantics.

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
