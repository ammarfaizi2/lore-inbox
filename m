Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266138AbUHATKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266138AbUHATKP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 15:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266133AbUHATKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 15:10:15 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:28717 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S266128AbUHATKL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 15:10:11 -0400
Date: Sun, 1 Aug 2004 21:11:18 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>, Adrian Bunk <bunk@fs.tum.de>
Cc: "Justin T. Gibbs" <gibbs@scsiguy.com>, Sam Ravnborg <sam@ravnborg.org>,
       James.Bottomley@HansenPartnership.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] let AIC7{9,X}XX_BUILD_FIRMWARE depend on !PREVENT_FIRMWARE_BUILD
Message-ID: <20040801191118.GA7402@mars.ravnborg.org>
Mail-Followup-To: "Justin T. Gibbs" <gibbs@scsiguy.com>,
	Adrian Bunk <bunk@fs.tum.de>, Sam Ravnborg <sam@ravnborg.org>,
	James.Bottomley@HansenPartnership.com, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20040801185543.GB2746@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040801185543.GB2746@fs.tum.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 01, 2004 at 08:55:44PM +0200, Adrian Bunk wrote:
> 
> The patch below lets AIC7{9,X}XX_BUILD_FIRMWARE depend on 
> !PREVENT_FIRMWARE_BUILD.

Justin, I agree with this change. Please let me know if I shall forward
the patch to Linus, or you will take care.

	Sam
