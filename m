Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267773AbUHMX7v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267773AbUHMX7v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 19:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267850AbUHMX7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 19:59:51 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:11697 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267773AbUHMX7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 19:59:37 -0400
Subject: Re: USB kernel oops 2.6.7
From: Lee Revell <rlrevell@joe-job.com>
To: andystewart@comcast.net
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200408131947.55873.andystewart@comcast.net>
References: <200408131947.55873.andystewart@comcast.net>
Content-Type: text/plain
Message-Id: <1092441613.803.40.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 13 Aug 2004 20:00:13 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-13 at 19:47, Andy Stewart wrote:

> Aug 13 19:22:28 tux /sbin/hotplug-stopped[0]: hotplugging not enabled. Run 
> rchotplug start
> Aug 13 19:22:28 tux /sbin/hotplug-stopped[0]: hotplugging not enabled. Run 
> rchotplug start

Was hotplugging enabled at the time, or is this message wrong?  If the
message is accurate, I would expect an Oops, the same way you often get
an Oops if you unplug any piece of hardware that's not hot pluggable
(assuming the hardware survives).

Lee

