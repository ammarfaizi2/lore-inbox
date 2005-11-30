Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751553AbVK3TiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751553AbVK3TiM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 14:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751558AbVK3TiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 14:38:12 -0500
Received: from smtp-103-wednesday.noc.nerim.net ([62.4.17.103]:11270 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S1751527AbVK3TiL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 14:38:11 -0500
Date: Wed, 30 Nov 2005 20:39:34 +0100
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PATCH] USB patches for 2.6.15-rc3
Message-Id: <20051130203934.0a63b52e.khali@linux-fr.org>
In-Reply-To: <20051130055607.GA4406@kroah.com>
References: <20051130055607.GA4406@kroah.com>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

> Jean Delvare:
>       hwmon: w83792d fix unused fan pins

Credits for this one actually go to Yuan Mu. Sorry for messing up the
attribution in my original patch.

-- 
Jean Delvare
