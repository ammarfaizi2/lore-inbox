Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261673AbVADPT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbVADPT1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 10:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261650AbVADPT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 10:19:27 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:46092 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261673AbVADPTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 10:19:17 -0500
Date: Tue, 4 Jan 2005 15:19:12 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Liam Girdwood <Liam.Girdwood@wolfsonmicro.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] AC97 plugin suspend/resume
Message-ID: <20050104151911.B22890@flint.arm.linux.org.uk>
Mail-Followup-To: Liam Girdwood <Liam.Girdwood@wolfsonmicro.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	lkml <linux-kernel@vger.kernel.org>
References: <1104850243.9143.333.camel@cearnarfon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1104850243.9143.333.camel@cearnarfon>; from Liam.Girdwood@wolfsonmicro.com on Tue, Jan 04, 2005 at 02:50:43PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 02:50:43PM +0000, Liam Girdwood wrote:
> This patch adds suspend and resume support to OSS AC97 plugins.
> 
> Changes :-
> 
>   o added suspend/resume callbacks to struct ac97_driver
>   o added suspend/resume handlers to ac97_codec.c
> 
> Signed-off-by: Liam Girdwood <liam.girdwood@wolfsonmicro.com>

Liam,

Please consider giving credit where credit is due.  Thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
