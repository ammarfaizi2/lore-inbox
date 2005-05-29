Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261215AbVE2Cs6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbVE2Cs6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 22:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbVE2Cs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 22:48:58 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:65450 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261215AbVE2Cs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 22:48:57 -0400
Subject: Re: RT patch acceptance
From: Lee Revell <rlrevell@joe-job.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Bill Huey <bhuey@lnxw.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Andi Kleen <ak@muc.de>, Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0505281953570.12903@montezuma.fsmlabs.com>
References: <m1br6zxm1b.fsf@muc.de>
	 <1117044019.5840.32.camel@sdietrich-xp.vilm.net>
	 <20050526193230.GY86087@muc.de>
	 <1117138270.1583.44.camel@sdietrich-xp.vilm.net>
	 <20050526202747.GB86087@muc.de> <4296ADE9.50805@yahoo.com.au>
	 <20050527120812.GA375@nietzsche.lynx.com> <429715DE.6030008@yahoo.com.au>
	 <20050527233645.GA2283@nietzsche.lynx.com> <4297EB57.5090902@yahoo.com.au>
	 <20050528054503.GA2958@nietzsche.lynx.com>
	 <Pine.LNX.4.61.0505281953570.12903@montezuma.fsmlabs.com>
Content-Type: text/plain
Date: Sat, 28 May 2005 22:48:53 -0400
Message-Id: <1117334933.11397.21.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-05-28 at 19:55 -0600, Zwane Mwaikambo wrote:
> Media apps are actually not that commonplace as far as hard realtime 
> applications are concerned.

Audio capture and playback always have a hard realtime constraint.  That
is, unless you don't mind your VoIP call sounding as crappy as a cell
phone...

Lee

