Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261227AbVF1TpQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbVF1TpQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 15:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbVF1Tnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 15:43:35 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:50368 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261189AbVF1Tlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 15:41:31 -0400
Date: Tue, 28 Jun 2005 20:41:30 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Lameter <christoph@lameter.com>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, ak@suse.de
Subject: Re: [PATCH] Read only syscall tables for x86_64 and i386
Message-ID: <20050628194130.GA32240@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Christoph Lameter <christoph@lameter.com>,
	Arjan van de Ven <arjan@infradead.org>,
	linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de
References: <Pine.LNX.4.62.0506281141050.959@graphe.net> <1119984975.3175.41.camel@laptopd505.fenrus.org> <Pine.LNX.4.62.0506281224030.1523@graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0506281224030.1523@graphe.net>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2005 at 12:26:43PM -0700, Christoph Lameter wrote:
> Note that AFS seems to be modifying the syscall table. Is that legit?

No.

