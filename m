Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964982AbWHWP2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964982AbWHWP2x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 11:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964964AbWHWP2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 11:28:52 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:2535 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964982AbWHWP2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 11:28:52 -0400
Date: Wed, 23 Aug 2006 16:28:31 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Stephane Eranian <eranian@frankl.hpl.hp.com>
Cc: linux-kernel@vger.kernel.org, eranian@hpl.hp.com
Subject: Re: [PATCH 1/18] 2.6.17.9 perfmon2 patch for review: introduction
Message-ID: <20060823152831.GC32725@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Stephane Eranian <eranian@frankl.hpl.hp.com>,
	linux-kernel@vger.kernel.org, eranian@hpl.hp.com
References: <200608230805.k7N85qo2000348@frankl.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608230805.k7N85qo2000348@frankl.hpl.hp.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

oh, and please give the patches useful subjects that descript the
patch, e.g. this one should be just:


    [PATCH 0/17] perfmon2: introduction

(yes, it's convention to number the introduction 0 and the actual patches
 1 to n)
