Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932390AbWE3TDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbWE3TDP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 15:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbWE3TDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 15:03:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33747 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932390AbWE3TDO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 15:03:14 -0400
Date: Tue, 30 May 2006 15:02:35 -0400
From: Dave Jones <davej@redhat.com>
To: Dominik Brodowski <linux@dominikbrodowski.net>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Ingo Molnar <mingo@elte.hu>, nanhai.zou@intel.com
Subject: Re: [patch 00/61] ANNOUNCE: lock validator -V1
Message-ID: <20060530190235.GC17218@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Arjan van de Ven <arjan@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
	Ingo Molnar <mingo@elte.hu>, nanhai.zou@intel.com
References: <20060529212109.GA2058@elte.hu> <6bffcb0e0605291528qe24a0a3r3841c37c5323de6a@mail.gmail.com> <20060529224107.GA6037@elte.hu> <20060529230908.GC333@redhat.com> <1148967947.3636.4.camel@laptopd505.fenrus.org> <20060530141006.GG14721@redhat.com> <1148998762.3636.65.camel@laptopd505.fenrus.org> <20060530145852.GA6566@redhat.com> <20060530171118.GA30909@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060530171118.GA30909@dominikbrodowski.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2006 at 07:11:18PM +0200, Dominik Brodowski wrote:

 > That's indeed a possible deadlock situation -- what's the
 > cpufreq_update_policy() call needed for in cpufreq_stat_cpu_callback anyway?

I was hoping you could enlighten me :)
I started picking through history with gitk, but my tk install uses
fonts that make my eyes bleed.  My kingdom for a 'git annotate'..

		Dave
-- 
http://www.codemonkey.org.uk
