Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266885AbUIXEUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266885AbUIXEUP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 00:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267170AbUIXEUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 00:20:15 -0400
Received: from holomorphy.com ([207.189.100.168]:49116 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266885AbUIXEUM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 00:20:12 -0400
Date: Thu, 23 Sep 2004 21:20:00 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ray Bryant <raybry@sgi.com>
Cc: Alexander Nyberg <alexn@telia.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: lockmeter in 2.6.9-rc2-mm2
Message-ID: <20040924042000.GT9106@holomorphy.com>
References: <41539FC1.7040001@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41539FC1.7040001@sgi.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2004 at 11:17:05PM -0500, Ray Bryant wrote:
> This seems to compile for me, at least, haven't gotten to do a test of it.
> Does the x86_64 stuff compile now?

AFAICT yes. I've been doing allyesconfig compiles for some header
cleanup sweeps on x86-64; LOCKMETER=y is set, and it compiles fine.


-- wli
