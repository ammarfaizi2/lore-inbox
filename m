Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263988AbTJOSiS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 14:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263986AbTJOShT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 14:37:19 -0400
Received: from modemcable137.219-201-24.mtl.mc.videotron.ca ([24.201.219.137]:46720
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S263983AbTJOSgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 14:36:22 -0400
Date: Wed, 15 Oct 2003 14:36:02 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Peter Maersk-Moller <peter@maersk-moller.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx lockup for SMP for 2.4.22
In-Reply-To: <3F8D8690.9040104@maersk-moller.net>
Message-ID: <Pine.LNX.4.53.0310151435310.2328@montezuma.fsmlabs.com>
References: <3F8D1377.3060509@maersk-moller.net> <3F8D3A47.1000804@maersk-moller.net>
 <Pine.LNX.4.53.0310151124180.2328@montezuma.fsmlabs.com>
 <3F8D8690.9040104@maersk-moller.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Oct 2003, Peter Maersk-Moller wrote:

> Assuming UP means uni-processor, do you then mean removing
> one of the processors or just disabling (ie. not enabling) SMP ?
> 
> The latter case (enabling IO-APIC and disabling SMP) makes the
> boot process halt when it come to activating the aic7xxx driver.

Thanks that's what i wanted to find out, which 2.4 kernel version does it 
work with?

