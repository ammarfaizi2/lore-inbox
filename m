Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272222AbTHDVp2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 17:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272226AbTHDVp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 17:45:28 -0400
Received: from user-0cal2fl.cable.mindspring.com ([24.170.137.245]:57861 "EHLO
	bender.davehollis.com") by vger.kernel.org with ESMTP
	id S272222AbTHDVpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 17:45:25 -0400
Message-ID: <3F2ED292.2040302@davehollis.com>
Date: Mon, 04 Aug 2003 17:39:30 -0400
From: David T Hollis <dhollis@davehollis.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030630
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: USB Mouse oddity with 2.6.0-test2-mm4 + 013int
X-Enigmail-Version: 0.76.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just went to 2.6.0-test2-mm4 with Con's 012/013 interactivity patches 
(from 2.6.0-test2-mm2) on my laptop and I'm now having an odd time with 
my USB mouse.  After a short period of time (5 minutes or less), it 
stops working entirely.  If I remove the usbmouse module and reload it, 
I get it back.  There is nothing in my logs or dmesg output stating any 
kind of problem.  Is anyone else seeing this problem?  Anyone happen to 
know where the problem may lie?

