Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269040AbRG3Rq6>; Mon, 30 Jul 2001 13:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269047AbRG3Rqt>; Mon, 30 Jul 2001 13:46:49 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:23701 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S269043AbRG3Rqo>; Mon, 30 Jul 2001 13:46:44 -0400
Importance: Normal
Subject: [PATCH] Mwave for kernel 2.4.7 (repost)
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.4a  July 24, 2000
Message-ID: <OF3276BC96.0BEE581B-ON85256A99.00600876@raleigh.ibm.com>
From: "Paul Schroeder" <paulsch@us.ibm.com>
Date: Mon, 30 Jul 2001 12:40:46 -0500
X-MIMETrack: Serialize by Router on D04NM208/04/M/IBM(Release 5.0.6 |December 14, 2000) at
 07/30/2001 01:46:36 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hmm..  I tried posting this yesterday, but I didn't see it show up on the
list...  Sorry if you're seeing this a second time...

Get it here:  http://oss.software.ibm.com/acpmodem/
Or directly:
http://oss.software.ibm.com/pub/acpmodem/mwave_linux-2.4.7.patch

changes:

- Cleanup proc stuff for picky compilers
- More consistent naming for module opts and /proc info (Thomas Hood)
- Sanity checking on port and irq values for register_serial() (Hood)
- In mwave_init, back out initialization steps properly (Hood)
- MW_TRACE macro now defined in Makefile (Hood)
- Driver parms actually work now (Hood)

Cheers...Paul..


---
Paul B Schroeder  <paulsch@us.ibm.com>
Software Engineer, Linux Technology Center
IBM Corporation, Austin, TX

