Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261763AbULBUm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbULBUm1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 15:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbULBUm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 15:42:26 -0500
Received: from mx1.redhat.com ([66.187.233.31]:24766 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261763AbULBUlS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 15:41:18 -0500
Date: Thu, 2 Dec 2004 20:40:42 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge: 50/51: Device mapper support.
Message-ID: <20041202204042.GD24233@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Nigel Cunningham <ncunningham@linuxmail.org>,
	Pavel Machek <pavel@ucw.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101300802.5805.398.camel@desktop.cunninghams> <20041125235829.GJ2909@elf.ucw.cz> <1101427667.27250.175.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101427667.27250.175.camel@desktop.cunninghams>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2004 at 11:07:47AM +1100, Nigel Cunningham wrote:
> On Fri, 2004-11-26 at 10:58, Pavel Machek wrote:
> > This needs to go through dm people....
> Yes. I'll look for contact details.
 
dm-devel@redhat.com
https://www.redhat.com/mailman/listinfo/dm-devel

Exposing dm internals like struct io to the rest of the kernel
is unlikely to be the right way to do things.

Alasdair
-- 
agk@redhat.com
