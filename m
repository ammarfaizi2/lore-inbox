Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264346AbUEJRQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264346AbUEJRQE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 13:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264538AbUEJRQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 13:16:04 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:4813 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S264346AbUEJRQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 13:16:03 -0400
Date: Mon, 10 May 2004 10:15:12 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Andreas Gruenbacher <agruen@suse.de>,
       Nathan Scott <nathans@sgi.com>
Subject: Re: [PATCH] 2.6.6 Have XFS use kernel-provided qsort
Message-ID: <20040510171512.GB12314@taniwha.stupidest.org>
References: <20040510050905.GB13889@taniwha.stupidest.org> <20040510125636.GJ9028@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040510125636.GJ9028@fs.tum.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2004 at 02:56:36PM +0200, Adrian Bunk wrote:

> This results in an empty file being left.

True, but it is/way mostly for illustrative purposes anyhow since XFS
changes end up going in via ptools some futzing would be required
anyhow.


  --cw
