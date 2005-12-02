Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750845AbVLBVTX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845AbVLBVTX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 16:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbVLBVTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 16:19:23 -0500
Received: from lug-owl.de ([195.71.106.12]:47823 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1750720AbVLBVTW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 16:19:22 -0500
Date: Fri, 2 Dec 2005 22:19:20 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] ip / ifconfig redesign
Message-ID: <20051202211920.GJ13985@lug-owl.de>
Mail-Followup-To: linux-net@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <200512022253.19029.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <200512022253.19029.a1426z@gawab.com>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-02 22:53:19 +0300, Al Boldi <a1426z@gawab.com> wrote:

> The obvious benefit here, would be the transparent ability for apps to bind 
> to addresses, regardless of the link existence.

# echo 1 > /proc/sys/net/ipv4/ip_nonlocal_bind

and/or bind to address 0 (aka 0.0.0.0) instead of a given IP address.

MfG, JBG

-- 
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             _ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  _ _ O
 für einen Freien Staat voll Freier Bürger"  | im Internet! |   im Irak!   O O O
ret = do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA));
