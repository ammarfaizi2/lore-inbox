Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264428AbUEMTMi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264428AbUEMTMi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 15:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264429AbUEMTMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 15:12:38 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:11275 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S264428AbUEMTMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 15:12:36 -0400
Subject: Re: 2.6.6-mm2 foibles
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: gene.heskett@verizon.net
Cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <200405131442.27573.gene.heskett@verizon.net>
References: <200405131442.27573.gene.heskett@verizon.net>
Content-Type: text/plain
Message-Id: <1084475560.1793.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-1) 
Date: Thu, 13 May 2004 21:12:40 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-05-13 at 20:42, Gene Heskett wrote:
> Greetings;
> 
> I just booted to a 2.6.6-mm2 kernel, and discoverd I had no sound.  So 
> I logged back out of x, and found I had no keyboard!  ssh'd in from 
> the firewall and rebooted it.
> 
> Both sound, and the backswitch from x were working perfectly up to and 
> including 2.6.6.

I'm also having problems with 2.6.6-mm2 and losing my keyboard. After
logging into X, after a while, the keyboard stops responding. However,
my USB mouse still works.

