Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265775AbUFRX15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265775AbUFRX15 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 19:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265777AbUFRX14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 19:27:56 -0400
Received: from outmail1.freedom2surf.net ([194.106.33.237]:26768 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S264906AbUFRX1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 19:27:41 -0400
Date: Sat, 19 Jun 2004 00:26:18 +0100
From: Ian Molton <spyro@f2s.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, tony@atomide.com,
       david-b@pacbell.net, jamey.hicks@hp.com, joshua@joshuawise.com,
       James.Bottomley@steeleye.com
Subject: Re: DMA API issues
Message-Id: <20040619002618.5650e16a.spyro@f2s.com>
In-Reply-To: <40D359B3.6080400@pobox.com>
References: <20040618175902.778e616a.spyro@f2s.com>
	<40D359B3.6080400@pobox.com>
Organization: The Dragon Roost
X-Mailer: Sylpheed version 0.9.12-gtk2-20040617 (GTK+ 2.4.1; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2004 17:08:03 -0400
Jeff Garzik <jgarzik@pobox.com> wrote:

> You _might_ convince the kernel DMA gurus that this could be done by 
> creating a driver-specific bus, and pointing struct device to that 
> internal bus, but that seems like an awful lot of work as opposed to the 
> wrappers.

Its an awful lot less work than re-writing all those drivers!
