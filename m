Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262038AbUKVK4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbUKVK4M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 05:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbUKVKyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 05:54:05 -0500
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:18560 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262062AbUKVKwS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 05:52:18 -0500
Date: Mon, 22 Nov 2004 11:48:06 +0100
From: Martin Waitz <tali@admingilde.org>
To: Jeff Dike <jdike@addtoit.com>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>,
       user-mode-linux-devel@lists.sourceforge.net,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: And another bug report for UML in latest Linux 2.6-BK repository.
Message-ID: <20041122104806.GI19738@admingilde.org>
Mail-Followup-To: Jeff Dike <jdike@addtoit.com>,
	Anton Altaparmakov <aia21@cam.ac.uk>,
	user-mode-linux-devel@lists.sourceforge.net,
	lkml <linux-kernel@vger.kernel.org>
References: <1100613788.24599.45.camel@imp.csi.cam.ac.uk> <200411180148.iAI1mGQ3006498@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <200411180148.iAI1mGQ3006498@ccure.user-mode-linux.org>
User-Agent: Mutt/1.3.28i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hoi :)

On Wed, Nov 17, 2004 at 08:48:16PM -0500, Jeff Dike wrote:
> aia21@cam.ac.uk said:
> > sleeping process 29410 got unexpected signal : 11
> > I now have to press Ctrl+C to get back to my shell. 
> 
> This one is slightly subtle, but I believe that it is fixed by the following 
> patch.

It fixes the problem for me. Please send the patch to Linus.

-- 
Martin Waitz
