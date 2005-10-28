Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965211AbVJ1Lxj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965211AbVJ1Lxj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 07:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965216AbVJ1Lxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 07:53:39 -0400
Received: from ns.ustc.edu.cn ([202.38.64.1]:30914 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S965211AbVJ1Lxi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 07:53:38 -0400
Date: Fri, 28 Oct 2005 20:04:07 +0800
From: WU Fengguang <wfg@mail.ustc.edu.cn>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck@vds.kolivas.org
Subject: Re: 2.6.14-ck1
Message-ID: <20051028120407.GA4116@mail.ustc.edu.cn>
Mail-Followup-To: WU Fengguang <wfg@mail.ustc.edu.cn>,
	Con Kolivas <kernel@kolivas.org>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>,
	ck@vds.kolivas.org
References: <200510282118.11704.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510282118.11704.kernel@kolivas.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2005 at 09:18:09PM +1000, Con Kolivas wrote:
> These are patches designed to improve system responsiveness and interactivity. 
> It is configurable to any workload but the default ck* patch is aimed at the 
> desktop and ck*-server is available with more emphasis on serverspace.
> ... 
> Added:
> +adaptive-readahead-4.patch
> We Fengguang's adaptive readahead patch. Please test and report experiences - 
> Wu has been cc'ed on this email, please keep him cc'ed for reports.
Thanks. I've done a lot testings and improvements these days, and will release a
new version soon.

Regards,
Wu Fengguang
