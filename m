Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261485AbUKTGT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261485AbUKTGT5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 01:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbUKTGT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 01:19:57 -0500
Received: from mail.joq.us ([67.65.12.105]:3212 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S261485AbUKTGTM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 01:19:12 -0500
To: Lee Revell <rlrevell@joe-job.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Torben Hohn <torbenh@informatik.uni-bremen.de>,
       Jody McIntyre <scjody@modernduck.com>, Chris Wright <chrisw@osdl.org>
Subject: Re: [PATCH] Realtime LSM
References: <87y8ha1wcb.fsf@sulphur.joq.us>
	<1100922902.1424.8.camel@krustophenia.net>
From: "Jack O'Quin" <joq@io.com>
Date: 20 Nov 2004 00:19:24 -0600
In-Reply-To: <1100922902.1424.8.camel@krustophenia.net>
Message-ID: <878y8xhwk3.fsf@sulphur.joq.us>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> writes:

> On Tue, 2004-11-09 at 16:39 -0600, Jack O'Quin wrote:
> > +#include <linux/module.h>
> > +#include <linux/security.h>
> 
> These seem to be the only two includes that are needed.
> 
> Any other objections to the patch?

Fine with me, as long as you're certain.  I'll be away for a few days,
so I can't make that change and test it right now, myself.
-- 
  joq
