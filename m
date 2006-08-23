Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751390AbWHWF0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbWHWF0z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 01:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbWHWF0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 01:26:55 -0400
Received: from asia.telenet-ops.be ([195.130.137.74]:41623 "EHLO
	asia.telenet-ops.be") by vger.kernel.org with ESMTP
	id S1751390AbWHWF0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 01:26:55 -0400
From: Peter Korsgaard <jacmet@sunsite.dk>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org, device@lanana.org
Subject: Re: [PATCH] Update Documentation/devices.txt
References: <87d5aserky.fsf@slug.be.48ers.dk>
	<Pine.LNX.4.61.0608221934120.14463@yvahk01.tjqt.qr>
Date: Wed, 23 Aug 2006 07:26:40 +0200
In-Reply-To: <Pine.LNX.4.61.0608221934120.14463@yvahk01.tjqt.qr> (Jan
	Engelhardt's message of "Tue, 22 Aug 2006 19:34:46 +0200 (MEST)")
Message-ID: <87sljo2fan.fsf@slug.be.48ers.dk>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jan" == Jan Engelhardt <jengelh@linux01.gwdg.de> writes:

Hi,

 >> 180 block	USB block devices
 >> -		  0 = /dev/uba		First USB block device
 >> -		  8 = /dev/ubb		Second USB block device
 >> -		 16 = /dev/ubc		Third USB block device
 >> -		    ...
 >> +		0 = /dev/uba		First USB block device
 >> +		8 = /dev/ubb		Second USB block device
 >> +		16 = /dev/ubc		Third USB block device
 >> + 		    ...

 Jan> What's the reason for this indent change?

I don't know - Torben?

-- 
Bye, Peter Korsgaard
