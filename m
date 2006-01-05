Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbWAEIMH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbWAEIMH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 03:12:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932120AbWAEIMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 03:12:07 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:38791 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932103AbWAEIMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 03:12:06 -0500
Subject: Re: mm/rmap.c negative page map count BUG.
From: Arjan van de Ven <arjan@infradead.org>
To: Dave Jones <davej@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060105074718.GF20809@redhat.com>
References: <20060103082609.GB11738@redhat.com>
	 <43BA630F.1020805@yahoo.com.au> <20060103135312.GB18060@redhat.com>
	 <20060104155326.351a9c01.akpm@osdl.org> <20060105074718.GF20809@redhat.com>
Content-Type: text/plain
Date: Thu, 05 Jan 2006 09:11:51 +0100
Message-Id: <1136448712.2920.4.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Quite a few Fedora users have hit it over the last year,
> but what I find fascinating is that there's not a single
> occurance of "BUG at mm/rmap.c" in our 2.6.9 based RHEL4 bug reports.

could mean it's caused by consumer hardware code...

