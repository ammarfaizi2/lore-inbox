Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265111AbUASOUB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 09:20:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265117AbUASOUB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 09:20:01 -0500
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:6783 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265111AbUASOUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 09:20:00 -0500
Date: Mon, 19 Jan 2004 08:19:49 -0600 (CST)
From: Ryan Reich <ryanr@uchicago.edu>
Reply-To: Ryan Reich <ryanr@uchicago.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: Overlapping MTRRs in 2.6.1
In-Reply-To: <20040119095003.GB8621@redhat.com>
Message-ID: <Pine.LNX.4.58.0401190818450.1003@ryanr.aptchi.homelinux.org>
References: <Pine.LNX.4.58.0401181458080.2194@ryanr.aptchi.homelinux.org>
 <20040119095003.GB8621@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jan 2004, Dave Jones wrote:

> On Sun, Jan 18, 2004 at 03:11:27PM -0600, Ryan Reich wrote:
>
>  > (WW) RADEON(0): [agp] AGP not available
>  >
>  > and finally,
>  >
>  > (II) RADEON(0): Direct rendering disabled
>
> Make sure you're loading both the agpgart module, *AND* the
> relevant chipset driver for your board, ie via-agp, intel-agp or the like.

Thanks, that's what I was doing.  I didn't notice that the system had changed
from 2.4.

-- 
Ryan Reich
ryanr@uchicago.edu
