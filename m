Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266680AbUGLBBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266680AbUGLBBR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 21:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266681AbUGLBBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 21:01:17 -0400
Received: from p508B7511.dip.t-dialin.net ([80.139.117.17]:53576 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S266680AbUGLBBL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 21:01:11 -0400
Date: Mon, 12 Jul 2004 02:59:02 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: 2.6: sound/oss/swarm_cs4297a.c still required?
Message-ID: <20040712005902.GA19170@linux-mips.org>
References: <20040712001604.GH4701@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040712001604.GH4701@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2004 at 02:16:04AM +0200, Adrian Bunk wrote:

> in 2.6 (I've checked 2.6.7-mm7) sound/oss/swarm_cs4297a.c is no longer 
> listed in sound/oss/Makefile. Was this accidential, or should this file 
> be removed?

Still partially merged only.

  Ralf
