Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760102AbWLCVkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760102AbWLCVkP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 16:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760109AbWLCVkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 16:40:15 -0500
Received: from smtpout.mac.com ([17.250.248.184]:13775 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1760102AbWLCVkN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 16:40:13 -0500
In-Reply-To: <m3ac2nt7o8.fsf@zoo.weinigel.se>
References: <200611190320_MC3-1-D21B-111C@compuserve.com> <Pine.LNX.4.64.0611190930370.3692@woody.osdl.org> <m3ac2nt7o8.fsf@zoo.weinigel.se>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <87041D5C-ECA9-494A-8210-93646FDEA943@mac.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [patch] PM: suspend/resume debugging should depend on SOFTWARE_SUSPEND
Date: Sun, 3 Dec 2006 16:40:04 -0500
To: Christer Weinigel <christer@weinigel.se>
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAA==
X-Brightmail-scanned: yes
X-Proofpoint-Virus-Version: vendor=fsecure engine=4.65.5446:2.3.11,1.2.37,4.0.164 definitions=2006-12-02_01:2006-12-01,2006-12-02,2006-12-01 signatures=0
X-Proofpoint-Spam-Details: rule=probablespam policy=default score=75 spamscore=75 ipscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx engine=3.1.0-0610180000 definitions=main-0612030011
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 19, 2006, at 17:04:23, Christer Weinigel wrote:
> With suspend-to-disk I can remove the battery (to put in a fresh  
> battery when traveling), try doing that with suspend-to-ram.

My PowerBook can do this with suspend-to-ram too; it has an internal  
capacitor or battery of some sort which charges in a few minutes and  
holds enough power to keep the RAM alive for around a minute while I  
swap batteries.

Cheers,
Kyle Moffett



