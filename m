Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264902AbTLCPRt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 10:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264903AbTLCPRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 10:17:49 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:31500 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S264902AbTLCPRn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 10:17:43 -0500
Date: Wed, 3 Dec 2003 15:42:54 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Andrew Clausen <clausen@gnu.org>
Cc: Norman Diamond <ndiamond@wta.att.ne.jp>, linux-kernel@vger.kernel.org
Subject: Re: Disk Geometries reported incorrectly on 2.6.0-testX
Message-ID: <20031203144254.GA7993@win.tue.nl>
References: <13d401c3b710$d6c17bf0$11ee4ca5@DIAMONDLX60> <20031130124916.GA5738@win.tue.nl> <20031203110605.GD1810@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031203110605.GD1810@gnu.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 03, 2003 at 10:06:06PM +1100, Andrew Clausen wrote:

> > The point is just that the Linux kernel has no idea about these BIOS
> > fantasies.
> 
> Can't you look inside BIOS memory, etc.?
> Even call interrupts to query this stuff?

Of course. And the details differ from BIOS to BIOS.

