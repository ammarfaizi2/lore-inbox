Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261981AbVAHW0B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261981AbVAHW0B (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 17:26:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbVAHWZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 17:25:31 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:6829 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261981AbVAHWYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 17:24:21 -0500
Subject: Re: [PATCH 1/5] WM97xx touch driver AC97 plugin
From: Lee Revell <rlrevell@joe-job.com>
To: Liam Girdwood <Liam.Girdwood@wolfsonmicro.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Zabolotny <zap@homelink.ru>, Ian Molton <spyro@f2s.com>,
       Vincent Sanders <vince@simtec.co.uk>
In-Reply-To: <1105106557.9143.1001.camel@cearnarfon>
References: <1105106557.9143.1001.camel@cearnarfon>
Content-Type: text/plain
Date: Sat, 08 Jan 2005 17:24:19 -0500
Message-Id: <1105223060.24592.133.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-07 at 14:02 +0000, Liam Girdwood wrote:
> The wm97xx AC97 plugin. This is the driver for the wm9705, wm9712 and
> wm9713.

Why an OSS driver and not ALSA?  OSS is deprecated.

Lee

