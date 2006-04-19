Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751322AbWDSXFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbWDSXFX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 19:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWDSXFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 19:05:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:1428 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751319AbWDSXFW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 19:05:22 -0400
Date: Wed, 19 Apr 2006 19:05:08 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@cuia.boston.redhat.com
To: Crispin Cowan <crispin@novell.com>
cc: Arjan van de Ven <arjan@infradead.org>, Tony Jones <tonyj@suse.de>,
       linux-kernel@vger.kernel.org, chrisw@sous-sol.org,
       linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 4/11] security: AppArmor - Core access controls
In-Reply-To: <44468817.5060106@novell.com>
Message-ID: <Pine.LNX.4.63.0604191904370.11063@cuia.boston.redhat.com>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
  <20060419174937.29149.97733.sendpatchset@ermintrude.int.wirex.com>
 <1145470230.3085.84.camel@laptopd505.fenrus.org> <44468817.5060106@novell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Apr 2006, Crispin Cowan wrote:
> Arjan van de Ven wrote:

> > that sounds too bad ;) 
> > If I manage to mount /etc/passwd as /tmp/passwd, you'll only find the
> > later and your entire security system seems to be down the drain.

> If you are a confined process, then you don't get to mount things, for 
> this reason, among others.

Are confined processes always restricted from starting
non-confined processes?

-- 
All Rights Reversed
