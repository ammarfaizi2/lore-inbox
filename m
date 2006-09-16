Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964874AbWIPXq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964874AbWIPXq0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 19:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964875AbWIPXq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 19:46:26 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14288 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964874AbWIPXq0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 19:46:26 -0400
Date: Sat, 16 Sep 2006 19:46:22 -0400
From: Dave Jones <davej@redhat.com>
To: devzero@web.de
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
Subject: Re: show all modules which taint the kernel ?
Message-ID: <20060916234622.GA28649@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, devzero@web.de,
	Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
References: <1313042030@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1313042030@web.de>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 16, 2006 at 08:58:20PM +0200, devzero@web.de wrote:
 > but that "Modules linked in: radeon(U) drm(U) ipv6(U) autofs4(U)...." message has been reported to originate from a fc5 (fedora) kernel. fedora probably also using that novell/suse extension ?

Different. The Fedora kernel reports U for modules that weren't shipped with
the Fedora kernel. (It uses gpg signed modules).

	Dave

