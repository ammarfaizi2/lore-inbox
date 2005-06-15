Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261431AbVFOAGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261431AbVFOAGn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 20:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbVFOAGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 20:06:43 -0400
Received: from serv01.siteground.net ([70.85.91.68]:13447 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S261431AbVFOAGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 20:06:42 -0400
Date: Tue, 14 Jun 2005 17:05:36 -0700 (PDT)
From: christoph <christoph@scalex86.org>
X-X-Sender: christoph@ScMPusgw
To: Andrew Morton <akpm@osdl.org>
cc: ak@suse.de, linux-kernel@vger.kernel.org, shai@scalex86.org
Subject: Re: [PATCH] Move some variables into the "most_readonly" section??
In-Reply-To: <20050614165818.6f83fa6c.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0506141704150.4225@ScMPusgw>
References: <Pine.LNX.4.62.0506071253020.2850@ScMPusgw> <20050608131839.GP23831@wotan.suse.de>
 <Pine.LNX.4.62.0506141551350.3676@ScMPusgw> <20050614162354.6aabe57e.akpm@osdl.org>
 <Pine.LNX.4.62.0506141644160.4099@ScMPusgw> <20050614165818.6f83fa6c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jun 2005, Andrew Morton wrote:

> > Yup that makes the whole thing much more sane. Can we specify multiple 
> > attributes to a variable?
> Seems OK?

Looks fine. Want a patch against the existing fixes in mm1? So that we 
have a whatever-fix-fix-fix-fix-fix-fix-fix?

