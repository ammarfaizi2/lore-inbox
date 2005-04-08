Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262939AbVDHTtB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262939AbVDHTtB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 15:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262940AbVDHTtB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 15:49:01 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:18861 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S262939AbVDHTtA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 15:49:00 -0400
X-ORBL: [68.120.153.162]
Date: Fri, 8 Apr 2005 12:48:58 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
Message-ID: <20050408194858.GC6294@taniwha.stupidest.org>
References: <20050408071428.GB3957@opteron.random> <Pine.LNX.4.58.0504080724550.28951@ppc970.osdl.org> <4256AE0D.201@tiscali.de> <Pine.LNX.4.58.0504081010540.28951@ppc970.osdl.org> <20050408171518.GA4201@taniwha.stupidest.org> <Pine.LNX.4.58.0504081037310.28951@ppc970.osdl.org> <20050408180540.GA4522@taniwha.stupidest.org> <Pine.LNX.4.58.0504081149010.28951@ppc970.osdl.org> <20050408191638.GA5792@taniwha.stupidest.org> <878y3t5aam.fsf@deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878y3t5aam.fsf@deneb.enyo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2005 at 09:38:09PM +0200, Florian Weimer wrote:

> Does sorting by inode number make a difference?

It almost certainly would.  But I can sort more intelligently than
that even (all the world isn't ext2/3).
