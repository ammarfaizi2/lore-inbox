Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265341AbUFXT22@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265341AbUFXT22 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 15:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265339AbUFXTXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 15:23:07 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:48853 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264965AbUFXTTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 15:19:00 -0400
Date: Thu, 24 Jun 2004 16:17:42 +0200
From: Pavel Machek <pavel@suse.cz>
To: linux-kernel@vger.kernel.org, Amit Gud <gud@eth.net>
Subject: Re: Elastic Quota File System (EQFS)
Message-ID: <20040624141742.GD698@openzaurus.ucw.cz>
References: <40d9ac40.674.0@eth.net> <200406231853.35201.mrwatts@fast24.co.uk> <1088016048.15211.10.camel@sage.kitchen> <001901c459cd_bc436e40_868209ca@home> <20040624115019.GA3614@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040624115019.GA3614@suse.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > What action should be taken can be specified by the user while making the
> > files elastic. He can either opt to delete the file, compress it or move it
> > to some place (backup) where he know he has write access. The corresponding
> 
> - having files disappear at the discretion of the filesystem seems to be
>   bad behaviour: either I need this file, then I do not want it to just
>   disappear, or I do not need it, and then I can delete it myself.


Actually, think .o or mozilla cache files... You don't need them, but if you have them,
things are faster.

				Pavel

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

