Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129681AbRBGSqN>; Wed, 7 Feb 2001 13:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130021AbRBGSqD>; Wed, 7 Feb 2001 13:46:03 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:3597 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S129373AbRBGSps>; Wed, 7 Feb 2001 13:45:48 -0500
Date: Wed, 07 Feb 2001 13:45:31 -0500
From: Chris Mason <mason@suse.com>
To: Vedran Rodic <vedran@renata.irb.hr>
cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: [reiserfs-list] Re: Apparent instability of reiserfs on 2.4.1
Message-ID: <552640000.981571531@tiny>
In-Reply-To: <20010207194125.A15780@renata.irb.hr>
X-Mailer: Mulberry/2.0.6b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday, February 07, 2001 07:41:25 PM +0100 Vedran Rodic
<vedran@renata.irb.hr> wrote:

> 
> So could some of this bugs also be present in 3.5.x version of reiserfs?
> Will you be fixing them for that version?
> 

This list of reiserfs bugs was all specific to the 3.6.x versions, and they
don't appear with the 3.5.x code.  You will probably have problems if you
compile 3.5.x reiserfs with an unpatched redhat gcc 2.96, though.  

-chris



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
