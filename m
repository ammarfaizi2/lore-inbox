Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268591AbUJTQqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268591AbUJTQqT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 12:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268655AbUJTQqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 12:46:14 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:14994 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268591AbUJTQmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 12:42:50 -0400
Subject: Re: [BK PATCH] I2C update for 2.6.9
From: Lee Revell <rlrevell@joe-job.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: greg@kroah.com, linux-kernel <linux-kernel@vger.kernel.org>,
       sensors@Stimpy.netroedge.com
In-Reply-To: <dLpBLFBx.1098287861.7976600.khali@gcu.info>
References: <dLpBLFBx.1098287861.7976600.khali@gcu.info>
Content-Type: text/plain
Message-Id: <1098290419.1429.67.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 20 Oct 2004 12:40:19 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-20 at 11:57, Jean Delvare wrote:
> Hi Greg,
> 
> >Here are some i2c driver fixes and updates for 2.6.9.  There is a new
> >chip and a new bus driver, as well as a bunch of minor fixes.  The
> >majority of these patches have been in the past few -mm releases.
> 
> It looks like only three of these patches actually hit the lm_sensors
> mailing-list, and I don't see any (not even this annoucement) on the
> LKML. Could it be that your patch generator went bad somehow?
> 

Probably a list issue, vger seems to be bogged down, I am seeing 12-24
hour delays since yesterday.

Lee

