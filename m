Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932460AbVIZS02@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbVIZS02 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 14:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbVIZS02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 14:26:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:2014 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932460AbVIZS01 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 14:26:27 -0400
Date: Mon, 26 Sep 2005 14:25:46 -0400
From: Dave Jones <davej@redhat.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Brian Gerst <bgerst@didntduck.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] CONFIG_IA32
Message-ID: <20050926182545.GJ19275@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Chris Wedgwood <cw@f00f.org>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Christoph Hellwig <hch@infradead.org>,
	Brian Gerst <bgerst@didntduck.org>, Andrew Morton <akpm@osdl.org>,
	lkml <linux-kernel@vger.kernel.org>
References: <4335DD14.7090909@didntduck.org> <20050925100525.GA14741@infradead.org> <Pine.LNX.4.61.0509251116430.1684@montezuma.fsmlabs.com> <20050926091456.GB26983@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050926091456.GB26983@taniwha.stupidest.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2005 at 02:14:56AM -0700, Chris Wedgwood wrote:
 > On Sun, Sep 25, 2005 at 11:18:18AM -0700, Zwane Mwaikambo wrote:
 > 
 > > ia32 has been in use much longer than x86_32 and more ubiquitous.
 > 
 > ia32 is confusing when you consider ia32el

It shouldn't be too difficult to explain it to both of the ia32el users.

		Dave

