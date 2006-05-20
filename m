Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751448AbWETAlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbWETAlL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 20:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbWETAlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 20:41:11 -0400
Received: from ns2.g-housing.de ([81.169.133.75]:28874 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S1751448AbWETAlK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 20:41:10 -0400
Date: Sat, 20 May 2006 01:40:24 +0100 (BST)
From: Christian Kujau <evil@g-house.de>
X-X-Sender: dummy@vaio.testbed.de
To: Christian Kujau <evil@g-house.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Mel Gorman <mel@csn.ul.ie>, Andy Whitcroft <apw@shadowen.org>
Subject: Re: SCSI ABORT with 2.6.17-rc4-mm1
In-Reply-To: <Pine.NEB.4.64.0605200058040.4276@vaio.testbed.de>
Message-ID: <Pine.NEB.4.64.0605200137230.4276@vaio.testbed.de>
References: <62331.192.18.1.5.1148071784.squirrel@housecafe.dyndns.org>
 <20060519141032.23de6eee.akpm@osdl.org> <Pine.NEB.4.64.0605200058040.4276@vaio.testbed.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 May 2006, Christian Kujau wrote:
> I tried to be "super-keen" and applied x.bz2 to pristine 2.6.17-rc4, but the 
> scsi error persists (logs, .config coming in a few minutes.)

Please see .config and dmesgs here:

http://www.nerdbynature.de/bits/2.6.17-rc4-mm2.x/

I'll try with ACPI disabled later on and let you know. If you have more 
patches to test/back-out I'll be happy to test. What puzzles me: sym53c8xx 
does not seem *too* exotic but I seem to be the only one whining...

Thanks,
Christian.
-- 
"The combination of a number of things to make existence worthwhile."
"Yes, the philosophy of 'none,' meaning 'all.'"
 		-- Spock and Lincoln, "The Savage Curtain", stardate 5906.4
