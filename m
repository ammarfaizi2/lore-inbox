Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261823AbVGKOOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbVGKOOT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 10:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbVGKOMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 10:12:30 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:50106 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261814AbVGKOKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 10:10:38 -0400
Date: Mon, 11 Jul 2005 16:10:29 +0200
From: Jan Kara <jack@suse.cz>
To: Nigel Kukard <nkukard@lbsd.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reiserfs + quotas in kernel 2.6.11.12
Message-ID: <20050711141029.GK12428@atrey.karlin.mff.cuni.cz>
References: <42CDA612.6000001@lbsd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42CDA612.6000001@lbsd.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> How stable is reiserfs quotas in 2.6.11.12?
  They should be pretty stable. At least I don't know about any reported
bugs in that or any newer version unless you are using 1KB blocks. With
1KB blocks there was a bug which should be fixed since 2.6.13-rc1 I
think.
								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
