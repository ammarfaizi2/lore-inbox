Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271011AbUJVOjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271011AbUJVOjH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 10:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271300AbUJVOjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 10:39:07 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:20673 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S271011AbUJVOiz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 10:38:55 -0400
Date: Fri, 22 Oct 2004 16:38:50 +0200
From: David Weinehall <tao@acc.umu.se>
To: Luc Saillard <luc@saillard.org>
Cc: Xavier Bestel <xavier.bestel@free.fr>,
       Luca Risolia <luca.risolia@studio.unibo.it>,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, akpm@osdl.org
Subject: Re: Linux 2.6.9-ac3
Message-ID: <20041022143850.GD1308@khan.acc.umu.se>
Mail-Followup-To: Luc Saillard <luc@saillard.org>,
	Xavier Bestel <xavier.bestel@free.fr>,
	Luca Risolia <luca.risolia@studio.unibo.it>,
	linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, akpm@osdl.org
References: <20041022101335.6dcf247a.luca.risolia@studio.unibo.it> <20041022092102.GA16963@sd291.sivit.org> <20041022143036.462742ca.luca.risolia@studio.unibo.it> <1098448494.31003.37.camel@gonzales> <20041022133327.GD16963@sd291.sivit.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041022133327.GD16963@sd291.sivit.org>
User-Agent: Mutt/1.4.1i
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pubkey_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2004 at 03:33:27PM +0200, Luc Saillard wrote:

[snip]

> I try gstreamer with amarok to play sound using alsa, and this does't work
> (segfault). Gstreamer seems too big to be the default for every applications,

[snip]

This sounds more like a problem with Amarok though; I'm
listening to music right now using Rhythmbox, which uses gstreamer as a
backend, and I'm using ALSA (granted, I have esd as an intermediate
layer).


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
