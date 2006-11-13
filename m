Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932673AbWKMSYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932673AbWKMSYe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 13:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932676AbWKMSYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 13:24:34 -0500
Received: from hansmi.home.forkbomb.ch ([213.144.146.165]:17181 "EHLO
	hansmi.home.forkbomb.ch") by vger.kernel.org with ESMTP
	id S932673AbWKMSYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 13:24:33 -0500
Date: Mon, 13 Nov 2006 19:24:30 +0100
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Jean Delvare <khali@linux-fr.org>, Stelian Pop <stelian@popies.net>,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       Andrew Morton <akpm@osdl.org>,
       "Aristeu S. Rozanski F." <aris@cathedrallabs.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>, Robert Love <rml@novell.com>,
       Rene Nussbaumer <linux-kernel@killerfox.forkbomb.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Apple Motion Sensor driver
Message-ID: <20061113182430.GA24570@hansmi.ch>
References: <1163280972.32084.13.camel@localhost.localdomain> <d120d5000611130704r258c8946p3994c5ba1e0187e9@mail.gmail.com> <1163431758.23444.8.camel@localhost.localdomain> <d120d5000611130753p172c2a69n260482052f623a46@mail.gmail.com> <1163434455.23444.14.camel@localhost.localdomain> <1163434826.2805.2.camel@ux156> <20061113191444.1519bdb9.khali@linux-fr.org> <1163441931.5399.16.camel@johannes.berg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1163441931.5399.16.camel@johannes.berg>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2006 at 07:18:51PM +0100, Johannes Berg wrote:
> Yeah well I figured we'd just put the parameter into userspace
> instead :)

Most games have such an option already. I remember Quake 3 to have one.
Shouldn't be too hard to implement for the Open Source games and I also
think this belongs into userspace, mainly because the interpretation of
the input might differ.

Greets,
Michael
