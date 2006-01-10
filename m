Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030413AbWAJWwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030413AbWAJWwW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 17:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030415AbWAJWwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 17:52:22 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:50887 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1030413AbWAJWwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 17:52:21 -0500
Subject: Re: Digital Audio Extraction with ATAPI drives far from perfect
From: Lee Revell <rlrevell@joe-job.com>
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Jens Axboe <axboe@suse.de>, Sebastian <sebastian_ml@gmx.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <43C4388B.4060905@keyaccess.nl>
References: <20060107115449.GB20748@section_eight.mops.rwth-aachen.de>
	 <20060107115947.GY3389@suse.de>
	 <20060107140843.GA23699@section_eight.mops.rwth-aachen.de>
	 <20060107142201.GC3389@suse.de>
	 <20060107160622.GA25918@section_eight.mops.rwth-aachen.de>
	 <43BFFE08.70808@wasp.net.au>
	 <20060107180211.GA12209@section_eight.mops.rwth-aachen.de>
	 <43C00C32.9050002@wasp.net.au> <20060109093025.GO3389@suse.de>
	 <20060109094923.GA8373@section_eight.mops.rwth-aachen.de>
	 <20060109100322.GP3389@suse.de>  <43C4388B.4060905@keyaccess.nl>
Content-Type: text/plain
Date: Tue, 10 Jan 2006 17:52:18 -0500
Message-Id: <1136933539.2007.88.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-10 at 23:43 +0100, Rene Herman wrote:
> One thing that _is_ different is that the SG_IO version very
> frequently (soft) locks up the machine, with: 

So you are saying that once you see the BUG: softlockup message the
system is unresponsive and must be rebooted?

Lee

