Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262737AbTFOTTn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 15:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262742AbTFOTTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 15:19:42 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:61312 "EHLO
	lapdancer.baythorne.internal") by vger.kernel.org with ESMTP
	id S262737AbTFOTTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 15:19:42 -0400
Subject: Re: bad: scheduling while atomic!
From: David Woodhouse <dwmw2@infradead.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030615181703.H5417@flint.arm.linux.org.uk>
References: <20030615142950.A32102@flint.arm.linux.org.uk>
	 <1055697278.1244.19.camel@lapdancer.baythorne.internal>
	 <20030615181703.H5417@flint.arm.linux.org.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1055705608.1244.40.camel@lapdancer.baythorne.internal>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5.dwmw2) 
Date: Sun, 15 Jun 2003 20:33:29 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-06-15 at 18:17, Russell King wrote:
> Yes, although I was considering sending that one myself.  If you're due
> to do another sync up, feel free to include that.

Well, given the 'NFTL aborts if add_mtd_blktrans functions exists,
rather calling it and aborting only it it returns non-zero' bug, I
suppose I am due such ;)

-- 
dwmw2

