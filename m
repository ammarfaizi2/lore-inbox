Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264051AbTEGP0E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 11:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264052AbTEGP0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 11:26:04 -0400
Received: from havoc.daloft.com ([64.213.145.173]:62367 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S264051AbTEGP0D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 11:26:03 -0400
Date: Wed, 7 May 2003 11:38:38 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Dick Streefland <dick.streefland@altium.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: The magical mystical changing ethernet interface order
Message-ID: <20030507153838.GD3583@gtf.org>
References: <20030507141458.B30005@flint.arm.linux.org.uk> <6632.3eb923bb.15701@altium.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6632.3eb923bb.15701@altium.nl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 07, 2003 at 03:18:19PM -0000, Dick Streefland wrote:
> Russell King <rmk@arm.linux.org.uk> wrote:
> | Its rather annoying when your dhcpd starts on the wrong interface.
> 
> You can avoid this by assigning new interface names with "nameif".

We all know this :)

Nonetheless it's still a bug.

	Jeff



