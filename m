Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282046AbRK0GGI>; Tue, 27 Nov 2001 01:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282766AbRK0GF7>; Tue, 27 Nov 2001 01:05:59 -0500
Received: from adsl-64-166-241-227.dsl.snfc21.pacbell.net ([64.166.241.227]:44048
	"EHLO www.hockin.org") by vger.kernel.org with ESMTP
	id <S282046AbRK0GFw>; Tue, 27 Nov 2001 01:05:52 -0500
From: Tim Hockin <thockin@hockin.org>
Message-Id: <200111270542.fAR5g3S15976@www.hockin.org>
Subject: Re: [PATCH] proc-based cpu affinity user interface
To: anton@samba.org (Anton Blanchard)
Date: Mon, 26 Nov 2001 21:42:02 -0800 (PST)
Cc: rml@tech9.net (Robert Love), linux-kernel@vger.kernel.org
In-Reply-To: <20011127153740.A13824@krispykreme> from "Anton Blanchard" at Nov 27, 2001 03:37:40 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Attached is my procfs-based implementation of a user interface for
> > getting and setting a task's CPU affinity.  Patch is against 2.4.16. 
> 
> Have you seen Andrew Mortons cpus_allowed patch?

I really need to push pset - I guess I should finish the 2.4.x port, eh?

www.hockin.org/~thockin/pset
