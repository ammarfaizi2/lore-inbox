Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269233AbUJFMQY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269233AbUJFMQY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 08:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269237AbUJFMQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 08:16:24 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:43244 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S269233AbUJFMQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 08:16:21 -0400
Date: Wed, 6 Oct 2004 14:16:25 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Console: fall back to /dev/null when no console is availlable
Message-ID: <20041006121625.GB8386@wohnheim.fh-wedel.de>
References: <20041005185214.GA3691@wohnheim.fh-wedel.de> <20041005163052.305f0d88.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041005163052.305f0d88.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 October 2004 16:30:52 -0700, Andrew Morton wrote:
> 
> /usr/src/25/init/main.c:183: undefined reference to `open'
> 
> I assume this worked for you because it's against 2.6.8 and we were still
> supporting kernel syscalls then.
> 
> Please always test patches against current kernels.

Or keep the brown paperbag nearby.  Doh!

> I'll fix it up.

Thanks.

Jörn

-- 
Public Domain  - Free as in Beer
General Public - Free as in Speech
BSD License    - Free as in Enterprise
Shared Source  - Free as in "Work will make you..."
