Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265363AbTL2TIu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 14:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265390AbTL2TIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 14:08:50 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:37603 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S265363AbTL2TGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 14:06:12 -0500
Date: Mon, 29 Dec 2003 20:06:06 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Samuel Flory <sflory@rackable.com>
Cc: Johannes Ruscheinski <ruschein@mail-infomine.ucr.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: Best Low-cost IDE RAID Solution For 2.6.x? (OT?)
Message-ID: <20031229190606.GF347@louise.pinerecords.com>
References: <20031228180424.GA16622@mail-infomine.ucr.edu> <3FEF8CFD.7060502@rackable.com> <20031229134150.GB30794@louise.pinerecords.com> <20031229185908.GB31215@mail-infomine.ucr.edu> <3FF07AD8.2040601@rackable.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FF07AD8.2040601@rackable.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec-29 2003, Mon, 11:04 -0800
Samuel Flory <sflory@rackable.com> wrote:

>   A word of advice when using software raid.  Be sure to run badblocks 
> on all the disks before creating your array.  Software raid isn't as 
> nice about bad sectors as most hardware raid controllers.  On the other 

_initial_ bad sectors, that is.

> hand the md driver kicks the ass of nearly every raid controller I've tried.

word.

-- 
Tomas Szepe <szepe@pinerecords.com>
