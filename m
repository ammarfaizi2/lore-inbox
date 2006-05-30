Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932429AbWE3TZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbWE3TZe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 15:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932434AbWE3TZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 15:25:33 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:26788 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S932429AbWE3TZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 15:25:32 -0400
X-IronPort-AV: i="4.05,190,1146466800"; 
   d="scan'208"; a="1815572763:sNHT32335526"
To: Dave Jones <davej@redhat.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Ingo Molnar <mingo@elte.hu>, nanhai.zou@intel.com
Subject: Re: [patch 00/61] ANNOUNCE: lock validator -V1
X-Message-Flag: Warning: May contain useful information
References: <20060529212109.GA2058@elte.hu>
	<6bffcb0e0605291528qe24a0a3r3841c37c5323de6a@mail.gmail.com>
	<20060529224107.GA6037@elte.hu> <20060529230908.GC333@redhat.com>
	<1148967947.3636.4.camel@laptopd505.fenrus.org>
	<20060530141006.GG14721@redhat.com>
	<1148998762.3636.65.camel@laptopd505.fenrus.org>
	<20060530145852.GA6566@redhat.com>
	<20060530171118.GA30909@dominikbrodowski.de>
	<20060530190235.GC17218@redhat.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 30 May 2006 12:25:29 -0700
In-Reply-To: <20060530190235.GC17218@redhat.com> (Dave Jones's message of "Tue, 30 May 2006 15:02:35 -0400")
Message-ID: <adafyir71sm.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 30 May 2006 19:25:30.0615 (UTC) FILETIME=[D05B0870:01C6841E]
Authentication-Results: sj-dkim-1.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Dave> I was hoping you could enlighten me :) I started picking
    Dave> through history with gitk, but my tk install uses fonts that
    Dave> make my eyes bleed.  My kingdom for a 'git annotate'..

Heh -- try "git annotate" or "git blame".  I think you need git 1.3.x
for that... details of where to send your kingdom forthcoming...

 - R.
