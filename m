Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932557AbWBPT1G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932557AbWBPT1G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 14:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbWBPT1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 14:27:05 -0500
Received: from mail.gmx.de ([213.165.64.20]:10717 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932557AbWBPT1A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 14:27:00 -0500
X-Authenticated: #271361
Date: Thu, 16 Feb 2006 20:26:49 +0100
From: Edgar Toernig <froese@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: matthias.andree@gmx.de, linux-kernel@vger.kernel.org, dhazelton@enter.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-Id: <20060216202649.28dec1fe.froese@gmx.de>
In-Reply-To: <43F4BF26.nail2KA210T4X@burner>
References: <43EB7BBA.nailIFG412CGY@burner>
	<Pine.LNX.4.61.0602140903400.7198@yvahk01.tjqt.qr>
	<43F1F196.nailMWZE1HZK5@burner>
	<200602141710.37869.dhazelton@enter.net>
	<43F4652F.nail20W57J1QB@burner>
	<20060216115204.GA8713@merlin.emma.line.org>
	<43F4BF26.nail2KA210T4X@burner>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling wrote:
>
> Matthias Andree <matthias.andree@gmx.de> wrote:
> 
> > > I usually fix real bugs immediately after I know them.
> >
> > "Usually" is the key here. Sometimes, you refuse to fix real bugs
> > forever even if you're made aware of them, and rather shift the blame
> > on somebody else.
> 
> Show me a single real bug that I did not fix.

Well, the kill(getppid(), SIG_INT)s in cdda2wav still cause system
reboots when run as root.

Ciao, ET.
