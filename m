Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262654AbUCJPVn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 10:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262662AbUCJPVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 10:21:43 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:30404 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262654AbUCJPVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 10:21:39 -0500
Subject: Re: [Announce] Emulex LightPulse Device Driver
From: James Bottomley <James.Bottomley@steeleye.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Smart, James" <James.Smart@Emulex.com>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <404ED33D.3070504@pobox.com>
References: <3356669BBE90C448AD4645C843E2BF2802C014D7@xbl.ma.emulex.com> 
	<404ED33D.3070504@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 10 Mar 2004 10:21:07 -0500
Message-Id: <1078932070.1807.34.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-03-10 at 03:35, Jeff Garzik wrote:
> Embark you shall, and let me join in the chorus of kudos for making the 
> leap to open source.  :)

Yes, I'll add my welcome to that.

[...]
> That should get you started ;-)

Actually, it would be my interpretation of the FAQ that most of this
work is already intended (although Jeff gave specific instances than the
generalities in the FAQ).

There were many more places than this in the driver that caused me to go
"good grief no".  However, it probably makes more sense if you work down
your todo list and come back for a review when you're nearing the end of
it.  That way you don't get boat loads of comments about things you were
planning to fix anyway.

James


