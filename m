Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262396AbVCVFgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262396AbVCVFgv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 00:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262516AbVCVFc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 00:32:58 -0500
Received: from bay101-f34.bay101.hotmail.com ([64.4.56.44]:11088 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262505AbVCVFcf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 00:32:35 -0500
Message-ID: <BAY101-F34D96549B67F217C938150FE4E0@phx.gbl>
X-Originating-IP: [64.4.56.206]
X-Originating-Email: [jay_roplekar@hotmail.com]
In-Reply-To: <20050321222701.GI17865@csclub.uwaterloo.ca>
From: "Jayant Roplekar" <jay_roplekar@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [SATA] sata-via : bug?
Date: Tue, 22 Mar 2005 05:32:30 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 22 Mar 2005 05:32:30.0797 (UTC) FILETIME=[8AC887D0:01C52EA0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>Any modes in the bios for the SATA ports?  Maybe it is in a mode not
>supported by linux.  I know the ICH5 only wanted to work for me in
>native (enhanced?) mode, not compatible (emulating PATA) mode.  Maybe
>via does something similar.  I am puzzles by the UDMA/133 message which
>makes no sense for SATA which should be 150 or 300 not 133.

>Len Sorensen

Len,

Thanks for the suggestion but I do not have any option of turning any modes 
on in the BIOS.
At this point I am thinking/hoping that  this is quirk introduced by mobo 
that is triggering this behavior in the driver that can be fixed by somebody 
easily. Although I do not have the skill set to device a solution.

Jay


