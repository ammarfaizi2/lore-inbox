Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263466AbTJ0Tmo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 14:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263478AbTJ0Tmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 14:42:44 -0500
Received: from pcp03211547pcs.gnscrp01.va.comcast.net ([68.49.96.184]:53889
	"EHLO charon.int.bittwiddlers.com") by vger.kernel.org with ESMTP
	id S263466AbTJ0Tmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 14:42:43 -0500
Date: Mon, 27 Oct 2003 14:42:39 -0500
To: Bradley Chapman <kakadu_croc@yahoo.com>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [WARNING WARNING] Lots and Lots of ACPI Debug Messages with
	2.6.0-test9!
Message-ID: <20031027194238.GA4280@bittwiddlers.com>
References: <20031026121726.47887.qmail@web40907.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031026121726.47887.qmail@web40907.mail.yahoo.com>
User-Agent: Mutt/1.5.4i
From: Matthew Harrell <lists-sender-14a37a@bittwiddlers.com>
X-Delivery-Agent: TMDA/0.86 (Venetian Way)
X-Primary-Address: mharrell@bittwiddlers.com
Reply-To: Matthew Harrell 
	  <mharrell-dated-1067715760.e354d9@bittwiddlers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


And your system actually boots?  I get screenfuls of similar messages but the
machine locks solid.  If I try to turn off acpi then it gets a little further
(although the orinico module causes a bunch of them) but then it locks solid
a few seconds after allowing me to log in.  I had to switch back to an earlier
version to get anything done



In local.linux.kernel, you wrote:
> I got a rude wakeup call when I checked my logs after booting 2.6.0-test9. I have
> gotten so many debug messages that the dmesg is overflowing with them!

-- 
  Matthew Harrell                          I no longer need to punish, deceive,
  Bit Twiddlers, Inc.                       or compromise myself, unless I want
  mharrell@bittwiddlers.com                 to stay employed.
