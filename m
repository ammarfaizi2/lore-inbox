Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264444AbUGHQl3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264444AbUGHQl3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 12:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264153AbUGHQl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 12:41:29 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:30735 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S264444AbUGHQl0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 12:41:26 -0400
Date: Thu, 8 Jul 2004 18:41:21 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Gabriel Paubert <paubert@iram.es>, tom st denis <tomstdenis@yahoo.com>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: 0xdeadbeef vs 0xdeadbeefL
Message-ID: <20040708164121.GA7496@pclin040.win.tue.nl>
References: <20040707184737.GA25357@infradead.org> <20040707185340.42091.qmail@web41112.mail.yahoo.com> <20040708093249.GC32629@iram.es> <20040708111521.GK12308@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040708111521.GK12308@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : kweetal.tue.nl 1074; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2004 at 12:15:21PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:

> - Dirichlet Principle bites you anyway.

Ah, it took me a few seconds to reconstruct what principle
you are referring to.

I am used to seeing "Dirichlet Principle" in a context where
one wants to solve a boundary value problem for certain elliptic
partial differential equations. (Then the principle states,
roughly, that the unique solution is found by minimizing
some integral.)

You invoke what I am used to call the pigeonhole principle.

Andries
