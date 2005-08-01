Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262227AbVHAAdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262227AbVHAAdM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 20:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262207AbVHAAc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 20:32:26 -0400
Received: from [81.2.110.250] ([81.2.110.250]:63213 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262204AbVHAAcY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 20:32:24 -0400
Subject: Re: Drivers for Ricoh SD Card Reader
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: =?ISO-8859-1?Q?Tom=E0s_N=FA=F1ez?= Lirola <tomas@criptos.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20147.195.77.63.25.1122548894.squirrel@webmail.criptos.com>
References: <20147.195.77.63.25.1122548894.squirrel@webmail.criptos.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Date: Mon, 01 Aug 2005 01:57:48 +0100
Message-Id: <1122857868.15622.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-07-28 at 13:08 +0200, Tomàs Núñez Lirola wrote:
>  Obviously, this answer is useless, but I don't know what to do now... Do
> you know if Ricoh has released specs before? Do you think IBM should have
> them?
> 
> What would you do in my place? Which should be the next step?

IBM like to be Linux friendly when its in their interest, not always
merely when its in yours. Thinkpads can be really problematic in this
area. SD is even messier because SD is supposed to be very proprietary
and secret and other such garbage. Intel have published enough that
where the low level h/w interface is known we can do SD.

I'd say the chances of you gettig the SD on the thinkpad working are
probably very low unless its connected via the internal USB

Alan

