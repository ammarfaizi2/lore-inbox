Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263375AbUCXNo1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 08:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263372AbUCXNo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 08:44:26 -0500
Received: from mx1.redhat.com ([66.187.233.31]:18108 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263365AbUCXNoZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 08:44:25 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16481.37048.39163.334516@neuro.alephnull.com>
Date: Wed, 24 Mar 2004 08:44:24 -0500
From: Rik Faith <faith@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Light-weight Auditing Framework
In-Reply-To: [Rik Faith <faith@redhat.com>] Tue 23 Mar 2004 15:55:32 -0500
References: <16464.30442.852919.24605@neuro.alephnull.com>
	<20040312185033.GA2507@us.ibm.com>
	<16472.5852.375648.739489@neuro.alephnull.com>
	<20040318004502.GA2595@us.ibm.com>
	<16480.42052.58724.753984@neuro.alephnull.com>
X-Key: 7EB57214; 958B 394D AD29 257E 553F  E7C7 9F67 4BE0 7EB5 7214
X-Url: http://www.redhat.com/
X-Mailer: VM 7.17; XEmacs 21.4; Linux 2.4.22-1.2163.nptl (neuro)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 23 Mar 2004 15:55:32 -0500,
   Rik Faith <faith@redhat.com> wrote:
> This patch is against 2.6.5-rc2, but also applies against 2.6.5-rc2-mm1.

The patch I posted was against 2.6.5-rc2-mm1 or
2.6.5-rc2+previous-audit-patches.  A complete patch that will apply
against vanilla 2.6.5-rc2 is available at:
    http://people.redhat.com/faith/audit/audit-20040324.0831.patch

