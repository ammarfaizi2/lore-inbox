Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262162AbVD1Qe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262162AbVD1Qe5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 12:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262163AbVD1Qe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 12:34:56 -0400
Received: from xarello.BCM.UMontreal.CA ([132.204.86.50]:65230 "EHLO xarello")
	by vger.kernel.org with ESMTP id S262162AbVD1Qez (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 12:34:55 -0400
Date: Thu, 28 Apr 2005 12:34:44 -0400
To: Dave Airlie <airlied@gmail.com>
Cc: ryantemporary@gmail.com, linux-kernel@vger.kernel.org,
       dri-devel@lists.sourceforge.net
Subject: Re: DRI lockup on R200, 2.6.11.7
Message-ID: <20050428163444.GK15405@xarello>
Reply-To: ryantemporary@gmail.com
References: <20050426202916.GA2635@xarello> <21d7e99705042801227ed5438e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <21d7e99705042801227ed5438e@mail.gmail.com>
User-Agent: Mutt/1.3.28i
From: foo@porto.bmb.uga.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2005 at 09:22:36AM +0100, Dave Airlie wrote:
> 2.6.12 should fix this, there is patch at:
> http://drm.bkbits.net:8080/drm-linus/gnupatch@424260f9PBUdlFvyiQw1maJBKvEtXA

Thanks a lot!  I will apply this tonight and report any further
misbehavior.

-ryan
