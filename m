Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424383AbWKJMYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424383AbWKJMYj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 07:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424394AbWKJMYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 07:24:39 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:10121 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1424383AbWKJMYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 07:24:39 -0500
Subject: Re: 2.6.19-rc5: Bad page state in process 'swapper'
From: Arjan van de Ven <arjan@infradead.org>
To: Andre Noll <maan@systemlinux.org>
Cc: ak@suse.de, discuss@x86-64.org, linux-kernel@vger.kernel.org
In-Reply-To: <20061110121151.GC29040@skl-net.de>
References: <20061110121151.GC29040@skl-net.de>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 10 Nov 2006 13:24:34 +0100
Message-Id: <1163161474.3138.691.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-10 at 13:11 +0100, Andre Noll wrote:
> Hi
> 
> just tried to boot 2.6.19-rc5 on a 2-way opteron 250 with 8G Ram:


doest memtest86 pass? which modules are in use?
(it looks like something splattered all over your memory)

