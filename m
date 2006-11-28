Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935740AbWK1J3d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935740AbWK1J3d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 04:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758642AbWK1J3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 04:29:33 -0500
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:42725 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S1757289AbWK1J3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 04:29:32 -0500
Date: Tue, 28 Nov 2006 10:29:30 +0100
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: avl@logic.at, linux-kernel@vger.kernel.org
Subject: Re: Allow turning off hpa-checking.
Message-ID: <20061128092930.GF2352@gamma.logic.tuwien.ac.at>
Reply-To: avl@logic.at
References: <20061122105735.GV6851@gamma.logic.tuwien.ac.at> <20061123170557.GY6851@gamma.logic.tuwien.ac.at> <20061127130953.GA2352@gamma.logic.tuwien.ac.at> <20061127133044.28b8b4ed@localhost.localdomain> <20061127160144.GB2352@gamma.logic.tuwien.ac.at> <20061127163328.3f1c12eb@localhost.localdomain> <20061127175647.GD2352@gamma.logic.tuwien.ac.at> <20061127181033.58e72d9a@localhost.localdomain> <20061127182943.GE2352@gamma.logic.tuwien.ac.at> <20061127195940.1b90a897@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061127195940.1b90a897@localhost.localdomain>
User-Agent: Mutt/1.3.28i
From: Andreas Leitgeb <avl@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2006 at 07:59:40PM +0000, Alan wrote:
> > size remains still constant, and the exceeding damaged sectors are 
> > auto-"hidden" by the drive by means of HPA.
> > Still incorrect?
> Still incorrect. HPA has nothing to do with damaged sectors. The damaged
> sectors are replaced from a pool of sectors that are reserved for this
> purpose.

Please re-read my previous mail.   I *explicitly* wrote that
I'm talking about drives, whose "reserved pool of extra/spare
sectors" was already exhausted. 

Considering that: still incorrect?
