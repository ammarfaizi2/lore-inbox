Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRBNJbd>; Wed, 14 Feb 2001 04:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129106AbRBNJbX>; Wed, 14 Feb 2001 04:31:23 -0500
Received: from mail.zmailer.org ([194.252.70.162]:34060 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S129051AbRBNJbP>;
	Wed, 14 Feb 2001 04:31:15 -0500
Date: Wed, 14 Feb 2001 11:31:07 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Peter Samuelson <peter@cadcamlab.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: lkml subject line
Message-ID: <20010214113107.W15688@mea-ext.zmailer.org>
In-Reply-To: <20010212133324.B15688@mea-ext.zmailer.org> <7vh2Hebmw-B@khms.westfalen.de> <3A885DFF.824AC093@inet.com> <20010214031125.B30531@cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010214031125.B30531@cadcamlab.org>; from peter@cadcamlab.org on Wed, Feb 14, 2001 at 03:11:25AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2001 at 03:11:25AM -0600, Peter Samuelson wrote:
> [Eli Carter]
> > Have you looked at the headers in an LK email?
> > 
> > Sender: linux-kernel-owner@vger.kernel.org
> > X-Mailing-List:         linux-kernel@vger.kernel.org
> > ^^^^^^^^^^^^^^ Should provide that List-Id you want.
> 
> You missed the point.  Certainly there are ways to identify LK mail.
> Kai is saying that since 'List-Id:' is an IETF proposed standard,
> Majordomo ought to use it.

	There is no STANDARDS TRACK  RFC  saying anything about  List-Id:.
	There are only some individual's submission for a draft about it.
	It is also way overdue to expire (Expires September 23, 1999), and
	it has not been updated, nor advanced towards RFC.

	There are issues where me and DaveM are as obstinate as Linus,
	inserting lots of junky headers and munging others (e.g. Subject:)
	is a big no-no.    You can hash the issue all you want, but you
	can't convince me and DaveM.

	That  X-Mailing-List:  is actually a LOOP detection measure.
	http://vger.kernel.org/lkml/#s3-9

	I do have some plans which will change things at VGER, but those
	details are not ready for publishing yet.

> Peter

/Matti Aarnio
