Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261717AbVC3CId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbVC3CId (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 21:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbVC3CId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 21:08:33 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:38065 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261717AbVC3CIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 21:08:30 -0500
Subject: Re: Mac mini sound woes
From: Lee Revell <rlrevell@joe-job.com>
To: Marcin Dalecki <martin@dalecki.de>
Cc: Takashi Iwai <tiwai@suse.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <0683ecb1e5fb577a703689d1962ad113@dalecki.de>
References: <1111966920.5409.27.camel@gaston>
	 <1112067369.19014.24.camel@mindpipe>
	 <4a7a16914e8d838e501b78b5be801eca@dalecki.de>
	 <1112084311.5353.6.camel@gaston>
	 <e5141b458a44470b90bfb2ecfefd99cf@dalecki.de>
	 <s5h7jjqkazy.wl@alsa2.suse.de>
	 <0683ecb1e5fb577a703689d1962ad113@dalecki.de>
Content-Type: text/plain
Date: Tue, 29 Mar 2005 21:08:28 -0500
Message-Id: <1112148508.5184.1.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-30 at 03:45 +0200, Marcin Dalecki wrote:
> On 2005-03-29, at 12:22, Takashi Iwai wrote:
> >
> > ALSA provides the "driver" feature in user-space because it's more
> > flexible, more efficient and safer than doing in kernel.  It's
> > transparent from apps perspective.  It really doesn't matter whether
> > it's in kernel or user space.
> 
> Yes because it's that wonder full linux sound processing sucks in 
> compare
> to the other OSs out there doing it in kernel.

What are you taking about?  It's actually quite good.

Have you actually tried these other OSes lately?  These devices in
question (those lacking hardware mixing and volume control) don't
exactly work great under that OS.

Lee

