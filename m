Return-Path: <linux-kernel-owner+w=401wt.eu-S1751020AbWLLJmn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020AbWLLJmn (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 04:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751017AbWLLJmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 04:42:43 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:40173 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019AbWLLJmm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 04:42:42 -0500
Subject: Re: [PATCH 0/1] V4L/DVB fix
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: V4L-DVB Maintainers <v4l-dvb-maintainer@linuxtv.org>,
       V4L <video4linux-list@redhat.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0612111838170.6452@woody.osdl.org>
References: <20061211091850.PS6310420000@infradead.org>
	 <Pine.LNX.4.64.0612111838170.6452@woody.osdl.org>
Content-Type: text/plain
Date: Tue, 12 Dec 2006 07:42:21 -0200
Message-Id: <1165916541.19952.59.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,


> > Please pull 'master' from:
> >         git://git.kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git master
> > It fixes a breakage when compiling on ia64.
> Did you forget to push out again?
Argh! Yes, it weren't pushed on my tree. Should be ok now.

updating 'refs/heads/master'
  from 9202f32558601c2c99ddc438eb3218131d00d413
  to   2a7e9a260ede3b17b5bc25c540a033a45bbf0461
updating 'refs/heads/origin'
  from 9202f32558601c2c99ddc438eb3218131d00d413
  to   4259cb25d436a79bf6b07d8075423573567c211d

Cheers, 
Mauro.

