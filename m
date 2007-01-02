Return-Path: <linux-kernel-owner+w=401wt.eu-S932672AbXABAOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932672AbXABAOZ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 19:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932684AbXABAOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 19:14:25 -0500
Received: from gate.crashing.org ([63.228.1.57]:50539 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932672AbXABAOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 19:14:24 -0500
Subject: Re: [PATCH] radeonfb: add support for newer cards
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Luca Tettamanti <kronos.it@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Solomon Peachy <pizza@shaftnet.org>,
       linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
In-Reply-To: <20070101214442.GA21950@dreamland.darkstar.lan>
References: <20070101212551.GA19598@dreamland.darkstar.lan>
	 <20070101214442.GA21950@dreamland.darkstar.lan>
Content-Type: text/plain
Date: Tue, 02 Jan 2007 11:14:13 +1100
Message-Id: <1167696853.23340.156.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2007-01-01 at 22:44 +0100, Luca Tettamanti wrote:
> Il Mon, Jan 01, 2007 at 10:25:51PM +0100, Luca Tettamanti ha scritto: 
> > Hi Ben, Andrew,
> > I've rebased 'ATOM BIOS patch' from Solomon Peachy to apply to 2.6.20.
> > The patch adds support for newer Radeon cards and is mainly based on
> > X.Org code.
> 
> And - for an easier review - this is the diff between
> radeonfb-atom-2.6.19-v6a.diff from Solomon and my patch (whitespace-only
> changes not included).

Ah good, what I was asking for :-) I'll try to get a new patch combining
everything out asap.

Ben.


