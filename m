Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261752AbUEEABr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbUEEABr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 20:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbUEEABr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 20:01:47 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:3535 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S261752AbUEEABq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 20:01:46 -0400
Date: Wed, 5 May 2004 01:01:05 +0100
From: Dave Jones <davej@redhat.com>
To: Michal Semler <cijoml@volny.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Marcello: cpufreq in 2.4.27???
Message-ID: <20040505000105.GA29963@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Michal Semler <cijoml@volny.cz>, linux-kernel@vger.kernel.org
References: <200405042148.36999.cijoml@volny.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405042148.36999.cijoml@volny.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2004 at 09:48:36PM +0200, Michal Semler wrote:

 > is it possible to include cpufreq into 2.4.27? We have new acpi, SATA, XFS 
 > included, so why not include cpufreq?

I'd bet largely because the upstream cpufreq maintainers
don't have time to maintain a 2.4 branch of it too.

Bruno Ducrot has been doing occasional backports, but it's a lot
of work, and if it got merged in 2.4, it'd likely only increase
the amount of work necessary.

		Dave

