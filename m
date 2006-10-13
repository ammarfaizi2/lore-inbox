Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751309AbWJMMSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbWJMMSv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 08:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751645AbWJMMSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 08:18:51 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:33455 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751309AbWJMMSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 08:18:51 -0400
Subject: Re: Current kernels break libdvdcss
From: Arjan van de Ven <arjan@infradead.org>
To: Bernhard Rosenkraenzer <bero@arklinux.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200610131408.53826.bero@arklinux.org>
References: <200610131408.53826.bero@arklinux.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 13 Oct 2006 14:18:46 +0200
Message-Id: <1160741926.3000.491.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-13 at 14:08 +0200, Bernhard Rosenkraenzer wrote:

> The player just says it can't open /dev/dvd with libdvdcss; after that, dmesg 
> points out
> 
> hdX: read_intr: Drive wants to transfer data the wrong way!


the error that caused this message got fixed in git yesterday..

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

