Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267455AbUBSSPs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 13:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267463AbUBSSPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 13:15:48 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:42427 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S267455AbUBSSPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 13:15:47 -0500
Date: Thu, 19 Feb 2004 19:15:39 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Problems booting with Kernel 2.6.2: filesystem is mounted read-only
Message-ID: <20040219181539.GA18269@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <1077213237.4213.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077213237.4213.14.camel@localhost.localdomain>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Feb 2004, Cedric Laczny wrote:

> Unfortunately I can't get a log of the failures, because it hangs during
> initialising the "Systemlogger". Before that, it starts kudzu, tries to
> acces some ksyms files in /var, initializes the eth0 interface and can't
> initialize the ppp0 interface.

So log across the network if you can't log locally.

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
