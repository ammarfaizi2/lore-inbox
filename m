Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261483AbTCGC4p>; Thu, 6 Mar 2003 21:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261482AbTCGC4p>; Thu, 6 Mar 2003 21:56:45 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:12235 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261483AbTCGC4o>; Thu, 6 Mar 2003 21:56:44 -0500
Date: Thu, 6 Mar 2003 22:07:16 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200303070307.h2737GU10861@devserv.devel.redhat.com>
To: Val Henson <val@nmt.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Those ruddy punctuation fixes
In-Reply-To: <mailman.1047000901.5238.linux-kernel2news@redhat.com>
References: <20030305111015.B8883@flint.arm.linux.org.uk> <20030305122008.GA4280@suse.de> <1046920285.3786.68.camel@spc1.mesatop.com> <mailman.1047000901.5238.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'd rather solve this problem by making standalone spelling fixes and
> other cosmetic changes taboo.  Cosmetic changes combined with actual
> useful code changes are fine with me.  If you're risking breaking the
> build, there should be some benefit that justifies the risk.

I generally reject combined patches which clean up and
change functions in places I maintain. The cleanup garbage
makes reviewing harder.

-- Pete
