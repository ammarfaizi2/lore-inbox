Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965191AbVJVBWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965191AbVJVBWS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 21:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbVJVBWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 21:22:18 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:5125 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751293AbVJVBWQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 21:22:16 -0400
Date: Fri, 21 Oct 2005 21:21:33 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Merging ATA passthru
Message-ID: <20051022012130.GD28212@tuxdriver.com>
Mail-Followup-To: Mark Lord <liml@rtr.ca>, Jeff Garzik <jgarzik@pobox.com>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <43593E0A.4070801@pobox.com> <43596160.3080407@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43596160.3080407@rtr.ca>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2005 at 05:45:04PM -0400, Mark Lord wrote:

> With passthru, it would really be much better to just leave it enabled
> without any option.  It's NOT on any main code path, and users/distros
> have to intentionally run "smartctl -d ata" or "hdparm /dev/sd*" to
> trigger any of it.

Actually, that's a good point.  I'm forced to concur with my
colleague... :-)

John
-- 
John W. Linville
linville@tuxdriver.com
