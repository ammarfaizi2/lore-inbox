Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964942AbWDMOKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964942AbWDMOKh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 10:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964943AbWDMOKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 10:10:36 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:27287 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964942AbWDMOKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 10:10:36 -0400
Message-ID: <443E5BBE.40804@sgi.com>
Date: Thu, 13 Apr 2006 16:10:06 +0200
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5 (X11/20060223)
MIME-Version: 1.0
To: Jes Sorensen <jes@sgi.com>, Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-xfs@oss.sgi.com, xfs-masters@oss.sgi.com,
       stern@rowland.harvard.edu, sekharan@us.ibm.com, akpm@osdl.org,
       David Chinner <dgc@sgi.com>
Subject: Re: notifier chain problem? (was Re: 2.6.17-rc1 did break XFS)
References: <20060413052145.GA31435@MAIL.13thfloor.at> <20060413072325.GF2732@melbourne.sgi.com> <yq0k69tuauh.fsf@jaguar.mkp.net> <20060413135000.GB6663@MAIL.13thfloor.at>
In-Reply-To: <20060413135000.GB6663@MAIL.13thfloor.at>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl wrote:
> sure, bootup is fine, as it boots on ext2/3 but once
> it is up, and I mount the newly created xfs filesystem
> the (virtual) machine (QEMU) panics ...
> 
> will provide all the data shortly via separated mail

What happens if you run it on real hardware? Would be nice to eliminate
QEMU from the equation, in case it doesn't like the funny split.

Cheers,
Jes


