Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264885AbUELBWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264885AbUELBWG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 21:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264155AbUELBJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 21:09:13 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:2273 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S264916AbUELBH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 21:07:57 -0400
Date: Tue, 11 May 2004 18:06:56 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Matt Porter <mporter@kernel.crashing.org>, benh@kernel.crashing.org,
       linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH 1/2] PPC32: New OCP core support
Message-ID: <20040511180656.B4901@home.com>
References: <20040511170150.A4743@home.com> <20040511175750.12bad316.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040511175750.12bad316.akpm@osdl.org>; from akpm@osdl.org on Tue, May 11, 2004 at 05:57:50PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2004 at 05:57:50PM -0700, Andrew Morton wrote:
> Matt Porter <mporter@kernel.crashing.org> wrote:
> >
> > New OCP infrastructure ported from 2.4 along with several
> > enhancements. Please apply.
> 
> I only received patch 1/2.
> 
> Could you please avoid using the same Subject: for different patches?  It
> confuses my auto-subject-to-patch-filename-munger and it's nice to more
> specifically identify each patch anwyay.

Oddly I sent unique subjects:

	Subject: [PATCH 1/2] PPC32: New OCP core support
	Subject: [PATCH 2/2] PPC32: PPC4xx updates for new OCP

It appears 2/2 at least made it off my system to the remote mailer,
will doublecheck.

-Matt
