Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264015AbTEWOry (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 10:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264059AbTEWOry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 10:47:54 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:35591 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S264015AbTEWOrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 10:47:53 -0400
Date: Fri, 23 May 2003 17:00:57 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21-rc3
Message-ID: <20030523150057.GD16938@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0305231437260.28118-100000@cam029208.student.utwente.nl> <3ECE1DBF.5090602@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ECE1DBF.5090602@gmx.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 May 2003, Carl-Daniel Hailfinger wrote:

> Martijn Uffing wrote:
> > Ave
> > 
> > Modular ide is still broken in 2.4.21-rc3  with my config.
> 
> IIRC, Alan said it is not suposed to work yet. However, if you're
> feeling brave (and have no valuable data), you can try to export these
> symbols to make depmod happy. (Please read on)

In that case, it's about time to disable "modular IDE" in the
corresponding config.in file if we're talking about "release candidate"
of a "stable" kernel?

If it's known to be broken, it shouldn't be allowed IMO.
