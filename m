Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263507AbUDEWPp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 18:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263511AbUDEWPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 18:15:43 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:41879 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263507AbUDEWO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 18:14:56 -0400
Date: Mon, 5 Apr 2004 23:12:03 +0100
From: Dave Jones <davej@redhat.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Cleanup cpufreq.c
Message-ID: <20040405221203.GT5688@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Pavel Machek <pavel@ucw.cz>,
	Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
	kernel list <linux-kernel@vger.kernel.org>
References: <20040405211130.GA3587@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040405211130.GA3587@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2004 at 11:11:30PM +0200, Pavel Machek wrote:
 > Hi!
 > 
 > This removes useless goto. Please apply,

Applied, thanks.

		Dave

