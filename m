Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261441AbUKSPew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261441AbUKSPew (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 10:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbUKSPev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 10:34:51 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:9606 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261441AbUKSPej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 10:34:39 -0500
Message-ID: <419E1297.4080400@namesys.com>
Date: Fri, 19 Nov 2004 07:34:47 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tridge@samba.org
CC: linux-kernel@vger.kernel.org
Subject: Re: performance of filesystem xattrs with Samba4
References: <16797.41728.984065.479474@samba.org>
In-Reply-To: <16797.41728.984065.479474@samba.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is this an fsync intensive benchmark?  If no, could you try with 
reiser4?  If yes, you might as well wait for us to optimize fsync first 
in reiser4.

Hans
