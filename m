Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261977AbVAHWWF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261977AbVAHWWF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 17:22:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbVAHWVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 17:21:38 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:35244 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261977AbVAHWUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 17:20:21 -0500
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
From: Lee Revell <rlrevell@joe-job.com>
To: ross@lug.udel.edu
Cc: "Jack O'Quin" <joq@io.com>, Chris Wright <chrisw@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       paul@linuxaudiosystems.com, arjanv@redhat.com, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <20050108165657.GA21760@jose.lug.udel.edu>
References: <200501071620.j07GKrIa018718@localhost.localdomain>
	 <1105132348.20278.88.camel@krustophenia.net>
	 <20050107134941.11cecbfc.akpm@osdl.org>
	 <20050107221059.GA17392@infradead.org>
	 <20050107142920.K2357@build.pdx.osdl.net> <87mzvkxxck.fsf@sulphur.joq.us>
	 <20050108165657.GA21760@jose.lug.udel.edu>
Content-Type: text/plain
Date: Sat, 08 Jan 2005 17:20:18 -0500
Message-Id: <1105222819.24592.131.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-01-08 at 11:56 -0500, ross@lug.udel.edu wrote:
> Not to mention that not everyone chooses to use PAM for precisely this
> reason.  Slackware has never included PAM and probably never will.
> My audio workstation has worked swell with the 2.4+caps solution and
> the 2.6+LSM solution.  PAM would break me ::-(

Hmm.  How could you (for example) configure all your machines to
authenticate against an LDAP server without PAM?

Lee

