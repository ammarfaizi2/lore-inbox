Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263510AbTL2NmA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 08:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263523AbTL2NmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 08:42:00 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:18146 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S263510AbTL2Nl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 08:41:59 -0500
Date: Mon, 29 Dec 2003 14:41:50 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Samuel Flory <sflory@rackable.com>
Cc: Johannes Ruscheinski <ruschein@mail-infomine.ucr.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: Best Low-cost IDE RAID Solution For 2.6.x? (OT?)
Message-ID: <20031229134150.GB30794@louise.pinerecords.com>
References: <20031228180424.GA16622@mail-infomine.ucr.edu> <3FEF8CFD.7060502@rackable.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FEF8CFD.7060502@rackable.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec-28 2003, Sun, 18:10 -0800
Samuel Flory <sflory@rackable.com> wrote:

> PS- Why not at least run software raid 5?  It takes far less cpu than 
> you'd think, and can save your ass.

Absolutely.  With eight low-cost IDE disks, you'd be nuts to go raid0
or linear.

-- 
Tomas Szepe <szepe@pinerecords.com>
