Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263151AbTCUCoq>; Thu, 20 Mar 2003 21:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263085AbTCUCoq>; Thu, 20 Mar 2003 21:44:46 -0500
Received: from smtp-out.comcast.net ([24.153.64.115]:16820 "EHLO
	smtp.comcast.net") by vger.kernel.org with ESMTP id <S263252AbTCUCm4>;
	Thu, 20 Mar 2003 21:42:56 -0500
Date: Thu, 20 Mar 2003 21:53:00 -0500
From: Matthew Harrell <lists-sender-14a37a@bittwiddlers.com>
Subject: Re: 2.5.65 jaz drive devfs oops
In-reply-to: <20030319235752.GA18086@bittwiddlers.com>
To: Christoph Hellwig <hch@infradead.org>,
       Kernel List <linux-kernel@vger.kernel.org>
Reply-to: Matthew Harrell 
	  <mharrell-dated-1048647184.0272a6@bittwiddlers.com>
Message-id: <20030321025300.GA13772@bittwiddlers.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.5.3i
X-Delivery-Agent: TMDA/0.68 (Shut Out)
X-Primary-Address: mharrell@bittwiddlers.com
References: <20030319191450.GA23769@bittwiddlers.com>
 <20030319193431.A28725@infradead.org> <20030319214522.GA7397@bittwiddlers.com>
 <20030319235752.GA18086@bittwiddlers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


And, even with "devfs=nomount" on the boot line and no devfs used I still
get the same error once the jaz drive totally cycles down.  

Besides building the kernel without devfs is there a good solution for this?

: Well, the second test just now didn't work right.
: /dev/scsi/host0/bus0/target4/lun0/disc did exist this time around but I got
: the same error as before trying to get anything going on it and I can no
: longer get the jaz drive to work.  

-- 
  Matthew Harrell                          Dogs have masters,
  Bit Twiddlers, Inc.                       cats have staff
  mharrell@bittwiddlers.com
