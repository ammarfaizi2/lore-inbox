Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263526AbTLBFhS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 00:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264284AbTLBFhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 00:37:18 -0500
Received: from dci.doncaster.on.ca ([66.11.168.194]:8595 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S263526AbTLBFhR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 00:37:17 -0500
To: Erik Steffl <steffl@bigfoot.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: libata in 2.4.24?
References: <Pine.LNX.4.44.0312010836130.13692-100000@logos.cnet>
	<3FCB8312.3050703@rackable.com> <87fzg4ckej.fsf@stark.dyndns.tv>
	<3FCBB15F.7050505@rackable.com> <3FCBB9F1.2080300@bigfoot.com>
In-Reply-To: <3FCBB9F1.2080300@bigfoot.com>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 02 Dec 2003 00:36:19 -0500
Message-ID: <87n0abbx2k.fsf@stark.dyndns.tv>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Erik Steffl <steffl@bigfoot.com> writes:

>    not for drives >133GB (I have intel D865PERL mb and 250GB matrox, it doesn't
> work without SCSI_ATA (at all), it cannot read/write above 133GB without libata
> patches)

My ICH5 was happily using my brand new 200GB SATA maxtor drive, at least up
until last Friday when it crashed. Grumble, a brand new drive.

I guess what I'm looking for is the "FAQ" or "README" file that most projects
have. What are the advantages of using the libata patch vs the stock drivers
and vice versa? What are the differences between the two?

-- 
greg

