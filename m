Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271373AbTHFUYu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 16:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272310AbTHFUYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 16:24:50 -0400
Received: from vitelus.com ([64.81.243.207]:2736 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id S271373AbTHFUXM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 16:23:12 -0400
Date: Wed, 6 Aug 2003 13:19:38 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Synaptics driver considered harmful
Message-ID: <20030806201938.GF2712@vitelus.com>
References: <20030806195931.GE2712@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030806195931.GE2712@vitelus.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 06, 2003 at 12:59:31PM -0700, Aaron Lehmann wrote:
> Index: drivers/input/mouse/Kconfig

AKPM seems to have a similar patch at
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test2/2.6.0-test2-mm3/broken-out/p00004_synaptics-optional.patch,
although it leaves the synaptics code in the kernel.
