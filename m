Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030384AbWBHMfB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030384AbWBHMfB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 07:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030388AbWBHMfB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 07:35:01 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:39625 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP
	id S1030384AbWBHMfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 07:35:00 -0500
Date: Wed, 8 Feb 2006 13:35:02 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: art <art@usfltd.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel-2.6.16-rc2-git4 --- reiserfs write problems !!!
Message-ID: <20060208123502.GA5775@stiffy.osknowledge.org>
References: <200602080024.AA52494644@usfltd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602080024.AA52494644@usfltd.com>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.16-rc2-marc-gac171c46-dirty
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* art <art@usfltd.com> [2006-02-08 00:24:05 -0600]:

> kernel-2.6.16-rc2-git4 --- reiserfs write problems
> 
> looks like with rc2 reiserfs have problem with writing - reading is ok
> 
> reiserfs is mounted on ext3 mount
> 
> with kernel-2.6.16-rc1-git6 works
> 
> any idea ???

Do you have any more info? dmesg? A calltrace? I cannot see anything weird
over here... :/

Marc
