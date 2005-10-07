Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbVJGHW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbVJGHW2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 03:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbVJGHW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 03:22:27 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:49891 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750788AbVJGHW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 03:22:27 -0400
Subject: Re: [PATCH] enable ac97_quirk hp_only for Acer Aspire 3003LCi
From: Lee Revell <rlrevell@joe-job.com>
To: Dick Streefland <dick@streefland.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051006192614.GA3300@streefland.xs4all.nl>
References: <20051006192614.GA3300@streefland.xs4all.nl>
Content-Type: text/plain
Date: Thu, 06 Oct 2005 22:11:43 -0400
Message-Id: <1128651104.17981.24.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-10-06 at 21:26 +0200, Dick Streefland wrote:
> On my Acer Aspire 3003LCi laptop, the speaker volume is not controlled
> by the master control, but by the headphone control. Enabling the
> "hp_only" quirk corrects this. The patch below adds this device to the
> list of known quirks.
> 
> Signed-off-by: Dick Streefland <dick@streefland.net>

Please send sound patches to alsa-devel at lists.sourceforge.net, not to
LKML.

Lee

