Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbVFFJDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbVFFJDc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 05:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbVFFJDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 05:03:32 -0400
Received: from gw.anda.ru ([83.146.86.58]:18181 "EHLO mail.ward.six")
	by vger.kernel.org with ESMTP id S261239AbVFFJD2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 05:03:28 -0400
Date: Mon, 6 Jun 2005 15:03:22 +0600
From: Denis Zaitsev <zzz@anda.ru>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PROBLEM] aic7xxx: DV failed to configure device
Message-ID: <20050606150321.A817@ward.six>
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20050606141638.A28532@ward.six> <1118045986.5652.21.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118045986.5652.21.camel@laptopd505.fenrus.org>; from arjan@infradead.org on Mon, Jun 06, 2005 at 10:19:45AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2005 at 10:19:45AM +0200, Arjan van de Ven wrote:
> On Mon, 2005-06-06 at 14:16 +0600, Denis Zaitsev wrote:
> > I'm testing an Adaptec SCSI controller + an IBM drive.  All the things
> > used to be fine before I had made the low-level format of the drive
> > (thru the Ctrl-A Adaptec's menu).  And now after
> > 
> >         modprobe aic7xxx
> 
> 
> you failed to mention which exact kernel you were using...

Yes, I'm sorry.  2.6.10.
