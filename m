Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbUCGLdb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 06:33:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261813AbUCGLda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 06:33:30 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:30459 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261812AbUCGLcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 06:32:10 -0500
Date: Sun, 7 Mar 2004 12:32:06 +0100
From: Thomas Mueller <linux-kernel@tmueller.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6 much worse than 2.4 on poor wlan reception
Message-ID: <20040307113153.GA3313@tmueller.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040304180154.GA1893@tmueller.com> <yq0znavsl57.fsf@wildopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <yq0znavsl57.fsf@wildopensource.com>
X-PGP-Key-FingerPrint: F921 8CA2 4BB6 CF07 4F5B 22FC CF8B A4C1 9570 2B3B
X-Operating-System: Debian Linux K2.6.2-1-686
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:2c17e390e92c60a8a0573432b44c4ce0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jes,

Jes Sorensen meinte am Friday, dem 05. March 2004:

> Thomas> Kernel 2.4 works far better in the poor reception situation I
> Thomas> have, anyone any idea what I could do without moving the AP or
> Thomas> laptop?  When I'm near my AP everything works fine with 2.6
> Thomas> too.
> 
> Start out by forcing it to a lower link speed, at that signal quality
> you really don't want to try and go above 2MBit/sec. If you keep
> trying to do 11MBit/sec the card will constantly try the higher rate
> and then lose signal, drop down and try again. Fixing the rate should
> improve the situation - at least it has always done so for me ;-)

I tried that (rate 2M auto) but that doesn't improve anything. I still
loose the connection to the AP, I don't think that happens less frequent
than at 11 MBit/s.


-- 
MfG Thomas Mueller - http://www.tmueller.com for pgp key (95702B3B)
