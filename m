Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261940AbUJ1Tc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261940AbUJ1Tc2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 15:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261962AbUJ1Tc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 15:32:27 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:51441 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261940AbUJ1TaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 15:30:20 -0400
Date: Thu, 28 Oct 2004 12:29:24 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: akpm@osdl.org, jdike@addtoit.com,
       user-mode-linux-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/7] uml: Build fix for TT w/o SKAS
Message-ID: <20041028192924.GD851@taniwha.stupidest.org>
References: <200410272223.i9RMNg921807@mail.osdl.org> <200410282049.42376.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410282049.42376.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2004 at 08:49:42PM +0200, Blaisorblade wrote:

> Drop that - the fix is in my tree currently, I'll forward it
> soon. And the fix, instead of #ifdef'ing it out, adds the support
> for using TT & SYSEMU.

SKAS / SYSEMU are entirely uninteresting right now until the host OS
support for these gets merged

i really don't think it's a good enough reason to hold other things up
and i'd prefer to see the fixes go in as-is and further updates ontop
of these
