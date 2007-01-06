Return-Path: <linux-kernel-owner+w=401wt.eu-S932254AbXAFWOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbXAFWOM (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 17:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbXAFWOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 17:14:12 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:33901 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932248AbXAFWOL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 17:14:11 -0500
Date: Sat, 6 Jan 2007 17:14:02 -0500
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Guilt 0.16
Message-ID: <20070106221402.GA22162@filer.fsl.cs.sunysb.edu>
References: <20070106184639.GC12543@filer.fsl.cs.sunysb.edu> <200701061957.l06JvVbP007499@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701061957.l06JvVbP007499@laptop13.inf.utfsm.cl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 06, 2007 at 04:57:31PM -0300, Horst H. von Brand wrote:
> Josef Sipek <jsipek@fsl.cs.sunysb.edu> wrote:
> > Guilt (Git Quilt) is a series of bash scripts which add a Mercurial
> > queues-like [1] functionality and interface to git.  The one distinguishing
> > feature from other quilt-like porcelains, is the format of the patches
> > directory. _All_ the information is stored as plain text - a series file and
> > the patches (one per file). This easily lends itself to versioning the
> > patches using any number of of SCMs.
> 
> A installation script/Makefile (or at least instructions) is missing...

Ah, good point. Just include the dir in your path. That's all.

/me goes to make a small makefile

Josef "Jeff" Sipek.

-- 
Humans were created by water to transport it upward.
