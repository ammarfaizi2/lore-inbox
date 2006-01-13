Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422746AbWAMRw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422746AbWAMRw4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 12:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422748AbWAMRw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 12:52:56 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:33733 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1422746AbWAMRwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 12:52:55 -0500
Date: Fri, 13 Jan 2006 12:52:48 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Lee Revell <rlrevell@joe-job.com>
cc: Roger Heflin <rheflin@atipa.com>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: Dual core Athlons and unsynced TSCs
In-Reply-To: <1137174463.15108.4.camel@mindpipe>
Message-ID: <Pine.LNX.4.58.0601131252300.8806@gandalf.stny.rr.com>
References: <EXCHG2003rmTIVvLVKi00000c7b@EXCHG2003.microtech-ks.com> 
 <1137168254.7241.32.camel@localhost.localdomain> <1137174463.15108.4.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 13 Jan 2006, Lee Revell wrote:

> I don't have hardware to test this, can you confirm that the only
> workaround needed is to boot with "clock=pmtmr"?

For which kernel?

-- Steve
