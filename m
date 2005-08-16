Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbVHPXPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbVHPXPb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 19:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbVHPXPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 19:15:31 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:53196
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S1750726AbVHPXPa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 19:15:30 -0400
Subject: Re: HDAPS, Need to park the head for real
From: Alejandro Bonilla Beeche <abonilla@linuxwireless.org>
Reply-To: abonilla@linuxwireless.org
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       hdaps devel <hdaps-devel@lists.sourceforge.net>
In-Reply-To: <20050816200708.GE3425@suse.de>
References: <1124205914.4855.14.camel@localhost.localdomain>
	 <20050816200708.GE3425@suse.de>
Content-Type: text/plain
Date: Tue, 16 Aug 2005 17:15:33 -0600
Message-Id: <1124234133.4855.73.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-16 at 22:07 +0200, Jens Axboe wrote:
> On Tue, Aug 16 2005, Alejandro Bonilla Beeche wrote:
> If I were in your position, I would just implement this for ide (pata,
> not sata) right now, since that is what you need to support (or do some
> of these notebooks come with sata?). So it follows that you add an ide

Some notebooks are coming up with a Sata controller I think, but is
still and IDE drive. I think some T43's come with that.

But, I will ask or check again later if we ever need this feature for
SATA.

.Alejandro

