Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932280AbWC1OX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbWC1OX0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 09:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbWC1OX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 09:23:26 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:21409 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932280AbWC1OXZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 09:23:25 -0500
Date: Tue, 28 Mar 2006 16:22:26 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: David Chinner <dgc@sgi.com>
cc: Peter Palfrader <peter@palfrader.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16: Oops - null ptr in blk_recount_segments?
In-Reply-To: <20060327061021.GT1173973@melbourne.sgi.com>
Message-ID: <Pine.LNX.4.61.0603281621210.27529@yvahk01.tjqt.qr>
References: <20060327022814.GV25288@asteria.noreply.org>
 <20060327043601.GE27189130@melbourne.sgi.com> <20060327045823.GW25288@asteria.noreply.org>
 <20060327061021.GT1173973@melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>These diffs:
>
>2006-01-18
>[XFS] Fix a race in xfs_submit_ioend() where we can ...
>2006-01-11
>[XFS] fix writeback control handling fix a reversed ...
>[XFS] cluster rewrites We can cluster mapped pages ...
>[...]

I bet on the 3rd...


Jan Engelhardt
-- 
