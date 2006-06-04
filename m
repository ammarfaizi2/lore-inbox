Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932307AbWFDXRq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbWFDXRq (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 19:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbWFDXRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 19:17:46 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:53720 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932307AbWFDXRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 19:17:46 -0400
Message-Id: <200606042317.k54NHfIS026034@dell2.home>
X-Mailer: exmh version 2.4 05/15/2001 with nmh-1.1
To: linux-kernel@vger.kernel.org
Subject: mixing cache size on xeon4's in smp system
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 04 Jun 2006 23:17:41 +0000
From: "Marty Leisner" <leisner@rochester.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	
I have a 2.4 gig hz xeon (533) with a 512k cache.
Can I use a 2.4 gig xeon  (533) with a 1Mbyte cache in an smp configuration?

Lets say it "works" -- what tools do I use to determine it really 
"works".

I've  heard advice "see if flakey things happen" -- that's not advice I want 
to follow...

Anyone have practical experiene with this?

marty


