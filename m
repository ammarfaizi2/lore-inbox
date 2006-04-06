Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751258AbWDFPvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbWDFPvt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 11:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbWDFPvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 11:51:49 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:59082 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751258AbWDFPvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 11:51:48 -0400
Subject: Re: [Alsa-devel] [BUG ALSA 2.6.17-rc1] Oops when Gaim tries to
	play sound
From: Lee Revell <rlrevell@joe-job.com>
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20060406132042.GF20402@harddisk-recovery.nl>
References: <20060406132042.GF20402@harddisk-recovery.nl>
Content-Type: text/plain
Date: Thu, 06 Apr 2006 11:51:45 -0400
Message-Id: <1144338706.2866.62.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-06 at 15:20 +0200, Erik Mouw wrote:
> Could be a locking error or an ALSA error, so message posted to lkml
> and alsa-devel lists. Feel free to ask for more information.

Already reported (several times) to both LKML and alsa-devel.

See kernel bugzilla #6329

