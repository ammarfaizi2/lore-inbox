Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275227AbTHGHWS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 03:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275229AbTHGHWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 03:22:17 -0400
Received: from iwoars.net ([217.160.110.113]:49935 "HELO iwoars.net")
	by vger.kernel.org with SMTP id S275227AbTHGHWR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 03:22:17 -0400
Date: Thu, 7 Aug 2003 09:23:08 +0200
From: Thomas Themel <themel@iwoars.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Device-backed loop broken in 2.6.0-test2?
Message-ID: <20030807072308.GB3741@iwoars.net>
References: <20030806224022.GA3741@iwoars.net> <20030806174043.27fd674a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030806174043.27fd674a.akpm@osdl.org>
User-Agent: Mutt/1.4i
X-Jabber-ID: themel0r@jabber.at
X-ICQ-UIN: 8774749
X-Postal: Hauptplatz 8/4, 9500 Villach, Austria
X-Phone: +43 676 846623 13
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Andrew Morton (akpm@osdl.org) wrote on 2003-08-07:
> Thomas Themel <themel@iwoars.net> wrote:
> > it seems that device backed loopback is broken in the 2.6.0-test2 series.
> doh.

Patch applied, and it at least withstood the initial restoration of the
8 GB of data onto it, which I never managed with the unpatched version.

Thanks!

ciao,
-- 
[*Thomas  Themel*] Great Goddess Discordia, Holy Mother Eris, 
[extended contact] Joy of the Universe, Laughter of Space, Grant 
[info provided in] us Life, Light, Love and Liberty and make the 
[*message header*] bloody magick work!
