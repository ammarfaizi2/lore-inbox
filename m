Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751804AbWCEVY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804AbWCEVY7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 16:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751805AbWCEVY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 16:24:59 -0500
Received: from main.gmane.org ([80.91.229.2]:56971 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751804AbWCEVY7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 16:24:59 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: [PATCH 001/001] PCI: PCI quirk for Asus A8V and A8V Deluxe motherboards
Date: Sun, 05 Mar 2006 21:24:21 +0000
Message-ID: <yw1x3bhwd1q2.fsf@agrajag.inprovide.com>
References: <20060305192709.GA3789@skyscraper.unix9.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 82.153.166.94
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.15 (linux)
Cancel-Lock: sha1:OrDynTV4/lOrcUq+6geP0e2w1d8=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bjd <bjdouma@xs4all.nl> writes:

> From: Bauke Jan Douma <bjdouma@xs4all.nl>
>
> On ASUS A8V and A8V Deluxe boards, the onboard AC97 audio controller
> and MC97 modem controller are deactivated when a second PCI soundcard
> is present.  This patch enables them.

Will this work with P4V8X boards too?  I've been quite annoyed by this
silly "feature".

-- 
Måns Rullgård
mru@inprovide.com

