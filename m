Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262909AbVAKWm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262909AbVAKWm4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 17:42:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262882AbVAKWm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 17:42:56 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:41153 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262909AbVAKWhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 17:37:05 -0500
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
From: utz lehmann <lkml@s2y4n2c.de>
To: Chris Wright <chrisw@osdl.org>
Cc: Matt Mackall <mpm@selenic.com>, Lee Revell <rlrevell@joe-job.com>,
       "Jack O'Quin" <joq@io.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, paul@linuxaudiosystems.com,
       arjanv@redhat.com, mingo@elte.hu, alan@lxorguk.ukuu.org.uk,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050111142142.Q10567@build.pdx.osdl.net>
References: <20050110212019.GG2995@waste.org>
	 <87d5wc9gx1.fsf@sulphur.joq.us> <20050111195010.GU2940@waste.org>
	 <871xcr3fjc.fsf@sulphur.joq.us> <20050111200549.GW2940@waste.org>
	 <1105475349.4295.21.camel@krustophenia.net>
	 <20050111124707.J10567@build.pdx.osdl.net>
	 <20050111212823.GX2940@waste.org>
	 <20050111134251.O10567@build.pdx.osdl.net>
	 <20050111221618.GA2940@waste.org>
	 <20050111142142.Q10567@build.pdx.osdl.net>
Content-Type: text/plain
Date: Tue, 11 Jan 2005 23:36:51 +0100
Message-Id: <1105483011.4692.55.camel@segv.aura.of.mankind>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:5a3828f1c4d839cf12e8a3b808f7ed34
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-11 at 14:21 -0800, Chris Wright wrote:
> * Matt Mackall (mpm@selenic.com) wrote:
> > On Tue, Jan 11, 2005 at 01:42:51PM -0800, Chris Wright wrote:

> > Also, tying to UIDs rather than (UID, executable) is worrisome as
> > random_game_with_audio in Gnome might decide it needs RT, much to the
> > admin's surprise.
> 
> Hmm, well, the pam_limit approach has that problem.

selinux?


