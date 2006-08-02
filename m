Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751096AbWHBDT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbWHBDT1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 23:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbWHBDT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 23:19:27 -0400
Received: from cantor.suse.de ([195.135.220.2]:9962 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751096AbWHBDT0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 23:19:26 -0400
From: Andi Kleen <ak@suse.de>
To: virtualization@lists.osdl.org
Subject: Re: [PATCH 0 of 13] Basic infrastructure patches for a paravirtualized kernel
Date: Wed, 2 Aug 2006 05:18:56 +0200
User-Agent: KMail/1.9.3
Cc: Jeremy Fitzhardinge <jeremy@xensource.com>, Andrew Morton <akpm@osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Ian Pratt <ian.pratt@xensource.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@sous-sol.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Christoph Lameter <clameter@sgi.com>
References: <patchbomb.1154462438@ezr>
In-Reply-To: <patchbomb.1154462438@ezr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608020518.56186.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 August 2006 22:00, Jeremy Fitzhardinge wrote:
> [ REPOST: Apologies to anyone who has seen this before.  It
>   didn't make it onto any of the lists it should have. -J ]

I tried to apply these patches (except the ones I didn't like:
8, 10, 12) to my tree, but couldn't because they are all
MIME demaged:

+       pte =3D (mm =3D=3D &init_mm) ?

etc.

Can you please repost a version without that (and ideally
fix 8, 10, 12)?

-Andi
