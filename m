Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263763AbTK2Nkn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 08:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263764AbTK2Nkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 08:40:43 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:54288 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263763AbTK2Nkm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 08:40:42 -0500
Date: Sat, 29 Nov 2003 08:29:35 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: AlberT@SuperAlberT.it
cc: lgb@lgb.hu, linux-kernel@vger.kernel.org
Subject: Re: hyperthreading
In-Reply-To: <200311251048.53046.AlberT_NOSPAM_@SuperAlberT.it>
Message-ID: <Pine.LNX.3.96.1031129082435.26461B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Nov 2003, Emiliano 'AlberT' Gabrielli wrote:


> P4 does not support HT ... only Xeon and new generation P4-HT does.

Not quite right, the 3.06GHz has HT enabled.
> 
> moreover you need olso a MB with HT support

IIRC there's a pin which must be powered to enable HT at boot, but I
believe Powerleap does make an adaptor to do that. AFAIK all P4's have HT,
but most have only one sibling, so there's no use or benefit from the
feature.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

