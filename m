Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261265AbVAMTBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbVAMTBs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 14:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261315AbVAMS6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 13:58:25 -0500
Received: from havoc.gtf.org ([63.115.148.101]:48775 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261307AbVAMSy5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 13:54:57 -0500
Date: Thu, 13 Jan 2005 13:54:53 -0500
From: David Eger <eger@havoc.gtf.org>
To: linux-kernel@vger.kernel.org
Subject: gcc randomly crashes on my PowerBook with recent kernels...
Message-ID: <20050113185453.GA10195@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I apologize for the vagueness of the message, but for all ye TiBook users,
over the last couple months of kernels, I've noticed gcc (various versions
in the 3.0 series randomly), non-deterministically crashing on large builds.

The builds tend to be fine and complete immediately after a reboot.
I've replaced my RAM recently, and the problem happened before and after
the replacement so I don't *think* it's the RAM.

Has anyone seen this sort of weird corruption behavior?  I don't know
where or how to start debugging this.  Could be anything... bad drivers,
bad builds of gcc.. Any ideas?  (and if you suggest d/ling a stock
compiler, instructions for doing this in gentoo would be appreciated ;-) )

-David
