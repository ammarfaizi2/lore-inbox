Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262597AbVAEUK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262597AbVAEUK3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 15:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262602AbVAEUK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 15:10:28 -0500
Received: from zeus.kernel.org ([204.152.189.113]:40123 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262597AbVAEUJv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 15:09:51 -0500
Date: Wed, 5 Jan 2005 20:04:40 +0100
From: Jurriaan on adsl-gate <thunder7@xs4all.nl>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.10-rc3-bk15 hanged under high load (i386)
Message-ID: <20050105190440.GA479@gates.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
References: <20050105183947.GA5601@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050105183947.GA5601@localhost>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2005 at 07:39:48PM +0100, Jose Luis Domingo Lopez wrote:
> Hi all:
> 
> 2.6.10-rc3-bk15
>   
>   Dec 29 20:41:38 dardhal kernel: swap_free: Bad swap offset entry 003f0000
> 
Did you have memtest86 run some loops over your memory?

HTH,
Jurriaan

