Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423131AbWJQGFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423131AbWJQGFj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 02:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423132AbWJQGFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 02:05:39 -0400
Received: from smtp113.sbc.mail.mud.yahoo.com ([68.142.198.212]:15997 "HELO
	smtp113.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1423131AbWJQGFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 02:05:38 -0400
Date: Mon, 16 Oct 2006 23:05:36 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Xavier Bestel <xavier.bestel@free.fr>, Neil Brown <neilb@suse.de>,
       linux-kernel@vger.kernel.org, aeb@cwi.nl,
       Jens Axboe <jens.axboe@oracle.com>
Subject: Re: Why aren't partitions limited to fit within the device?
Message-ID: <20061017060536.GB30598@tuatara.stupidest.org>
References: <17710.54489.486265.487078@cse.unsw.edu.au> <1160752047.25218.50.camel@localhost.localdomain> <17714.52626.667835.228747@cse.unsw.edu.au> <1160983735.32674.4.camel@frg-rhel40-em64t-03> <1160996072.24237.13.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160996072.24237.13.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2006 at 11:54:32AM +0100, Alan Cox wrote:

> Incidentally the question of exactly what libata should do about HPA
> handling also needs sorting out.

HPA isn't even uncommon, lots of laptops use it for recovery purposes
it seems.
