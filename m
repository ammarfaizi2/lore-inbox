Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261979AbUCWESA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 23:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261987AbUCWESA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 23:18:00 -0500
Received: from holomorphy.com ([207.189.100.168]:11155 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261979AbUCWER5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 23:17:57 -0500
Date: Mon, 22 Mar 2004 20:17:48 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Joe Korty <joe.korty@ccur.com>
Cc: Andrew Morton <akpm@osdl.org>, Paul Jackson <pj@sgi.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] broken bitmap_parse for ncpus > 32
Message-ID: <20040323041748.GA2045@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Joe Korty <joe.korty@ccur.com>, Andrew Morton <akpm@osdl.org>,
	Paul Jackson <pj@sgi.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20040322202118.GA27281@tsunami.ccur.com> <20040322231246.GQ2045@holomorphy.com> <20040323001433.GA29320@tsunami.ccur.com> <20040323020907.GU2045@holomorphy.com> <20040323041012.GA30322@tsunami.ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040323041012.GA30322@tsunami.ccur.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2004 at 06:09:07PM -0800, William Lee Irwin III wrote:
>> Sorry about not being clear; I meant the : and @ stuff I've seen around
>> various comments that somehow gets yanked directly out of C comments in
>> the source and generated into a pdf.

On Mon, Mar 22, 2004 at 11:10:13PM -0500, Joe Korty wrote:
> Ah, I see.  Here is the New-n-Improved patch:

Cool! I wouldn't have said it was a requirement, but I certainly like
the updated patch.


-- wli
