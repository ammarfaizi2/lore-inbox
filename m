Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263897AbTFWHFH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 03:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263922AbTFWHFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 03:05:06 -0400
Received: from pub237.cambridge.redhat.com ([213.86.99.237]:50379 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id S263897AbTFWHFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 03:05:04 -0400
Subject: Re: [PATCH] Fix mtdblock / mtdpart / mtdconcat
From: David Woodhouse <dwmw2@redhat.com>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       David Woodhouse <dwmw2@cambridge.redhat.com>
In-Reply-To: <20030623010031.E16537@flint.arm.linux.org.uk>
References: <20030623010031.E16537@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Red Hat UK Ltd.
Message-Id: <1056352749.29264.0.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5.dwmw2) 
Date: Mon, 23 Jun 2003 08:19:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-23 at 01:00, Russell King wrote:
> Dirtily disable ECC support; it doesn't work when mtdpart is layered
> on top of mtdconcat on top of CFI flash.

Please define "doesn't work".

-- 
dwmw2
