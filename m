Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265946AbUBKSKU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 13:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265954AbUBKSKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 13:10:19 -0500
Received: from h0060089601a0.ne.client2.attbi.com ([24.34.92.88]:36811 "EHLO
	sevoog.kriation.com") by vger.kernel.org with ESMTP id S265946AbUBKSJH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 13:09:07 -0500
Date: Wed, 11 Feb 2004 13:08:29 -0500
From: Armen Kaleshian <akaleshian@kriation.com>
To: "Dott. Surricani" <surricani@surricani.cjb.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SATA Problems.
Message-ID: <20040211180829.GA6190@sevoog.kriation.com>
References: <402A6BE8.6050006@surricani.cjb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <402A6BE8.6050006@surricani.cjb.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Have you tried adjusting the drive parameters with hdparm?

On Wed, Feb 11, 2004 at 06:52:40PM +0100, Dott. Surricani wrote:
: Hy all.
: 
: I have a problem when I try to use a SATA drive in Linux 2.6.xxx.
: 
: The kernel, can mount the drive but tell me continuosly DMA error...
: 
: What's wrong?
: 
: I have a Silicon Image 3112a .... And I include the drive in the kernel...
: 
: Thanks
: 
: surricani@surricani.cjb.net
: 
: -
: To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
: the body of a message to majordomo@vger.kernel.org
: More majordomo info at  http://vger.kernel.org/majordomo-info.html
: Please read the FAQ at  http://www.tux.org/lkml/
