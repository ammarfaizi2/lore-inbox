Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751836AbWFVRRm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751836AbWFVRRm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 13:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751838AbWFVRRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 13:17:42 -0400
Received: from gw.goop.org ([64.81.55.164]:45738 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751836AbWFVRRl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 13:17:41 -0400
Message-ID: <449AD0BB.1080702@goop.org>
Date: Thu, 22 Jun 2006 10:17:47 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
CC: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, pavel@suse.cz, linux-pm@osdl.org
Subject: Re: [linux-pm] swsusp regression [Was: 2.6.17-mm1]
References: <Pine.LNX.4.44L0.0606221144190.8121-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0606221144190.8121-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern wrote:
> Is it really true that this patch has been sitting in -mm for several
> months (as stated in the cover message to Linus for the new batch of
> changes for 2.6.17 sent in yesterday)?
>   
2.6.17-pre6-mm2 works perfectly for me.  17-mm1 has this problem.

    J
