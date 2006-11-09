Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424174AbWKISPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424174AbWKISPP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 13:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424183AbWKISPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 13:15:15 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:34290 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1424174AbWKISPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 13:15:13 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Subject: Re: [Cbe-oss-dev] [RFC, PATCH 2/2] Oprofile-on-Cell prereqs: Export hrtimer_forward
Date: Thu, 9 Nov 2006 19:14:50 +0100
User-Agent: KMail/1.9.5
Cc: Kevin Corry <kevcorry@us.ibm.com>, linuxppc-dev@ozlabs.org,
       oprofile-list@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <200611090858.11590.kevcorry@us.ibm.com> <200611090902.39714.kevcorry@us.ibm.com>
In-Reply-To: <200611090902.39714.kevcorry@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611091914.51783.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 November 2006 16:02, Kevin Corry wrote:
> Add a symbol-export for kernel/hrtimer.c::hrtimer_forward(). This routine
> is needed by the upcoming Oprofile-for-Cell patches, since Oprofile can
> be built as a module.
> 
> Signed-Off-By: Kevin Corry <kevcorry@us.ibm.com>

Applied, thanks. I'll forward it along with the other patches when
the set is complete.

	Arnd <><
