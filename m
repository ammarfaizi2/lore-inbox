Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbUKTHpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbUKTHpN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 02:45:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbUKTHpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 02:45:13 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:36744 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261152AbUKTHpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 02:45:09 -0500
Subject: Re: [PATCH] Realtime LSM
From: Lee Revell <rlrevell@joe-job.com>
To: "Jack O'Quin" <joq@io.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Torben Hohn <torbenh@informatik.uni-bremen.de>,
       Jody McIntyre <scjody@modernduck.com>, Chris Wright <chrisw@osdl.org>
In-Reply-To: <878y8xhwk3.fsf@sulphur.joq.us>
References: <87y8ha1wcb.fsf@sulphur.joq.us>
	 <1100922902.1424.8.camel@krustophenia.net>  <878y8xhwk3.fsf@sulphur.joq.us>
Content-Type: text/plain
Date: Sat, 20 Nov 2004 01:43:22 -0500
Message-Id: <1100933003.6879.6.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-11-20 at 00:19 -0600, Jack O'Quin wrote:
> > > +#include <linux/module.h>
> > > +#include <linux/security.h>
> > 
> > These seem to be the only two includes that are needed.
> > 
> > Any other objections to the patch?
> 
> Fine with me, as long as you're certain.  I'll be away for a few days,
> so I can't make that change and test it right now, myself.

Well I am certain it works with the current kernel.

The change could break older kernels, so I did not commit anything.

Lee



