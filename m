Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265223AbUFAVS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265223AbUFAVS7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 17:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265229AbUFAVS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 17:18:59 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:60849 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S265223AbUFAVS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 17:18:57 -0400
Date: Tue, 1 Jun 2004 14:18:22 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Adrian Bunk <bunk@fs.tum.de>,
       Eric BEGOT <eric_begot@yahoo.fr>,
       Alexander Gran <alex@zodiac.dnsalias.org>
Subject: Re: 2.6.7-rc2-mm1
Message-ID: <20040601211822.GA25161@taniwha.stupidest.org>
References: <20040601021539.413a7ad7.akpm@osdl.org> <200406011351.10669@zodiac.zodiac.dnsalias.org> <40BC746F.8070501@yahoo.fr> <20040601161940.GG25681@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040601161940.GG25681@fs.tum.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2004 at 06:19:41PM +0200, Adrian Bunk wrote:

> add-qsort-library-function depends on the XFS qsort patches you
> removed (and it's currently not used by anything else).

Andrew,

Can you just drop this for now until I get a chance to suck down -mm
and redo this properly?


Thanks,
  --cw
