Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750977AbWCaAny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbWCaAny (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 19:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbWCaAnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 19:43:53 -0500
Received: from mx1.redhat.com ([66.187.233.31]:23739 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750977AbWCaAnx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 19:43:53 -0500
To: Valerie Henson <val_henson@linux.intel.com>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, Tushar <tushar.telichari@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: DTrace for Linux
References: <323d1f6f0603282214m4a2c65b0t2e2bf7e74352e5f@mail.gmail.com>
	<20060328225203.7443c09f.rdunlap@xenotime.net>
	<20060330205537.GF16173@goober>
From: fche@redhat.com (Frank Ch. Eigler)
Date: 30 Mar 2006 19:43:41 -0500
In-Reply-To: <20060330205537.GF16173@goober>
Message-ID: <y0mr74jcuki.fsf@ton.toronto.redhat.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Valerie Henson <val_henson@linux.intel.com> writes:

> [...]  My opinion is that a port of DTrace to Linux would be
> extremely valuable, above and beyond the goals of SystemTap.  It is
> also my opinion that it will be extremely difficult. :)

Beyond the technical challenges, a legal one (SCSL-vs-GPL license
incompatibility) would at least complicate deployment of a plain port.

- FChE
