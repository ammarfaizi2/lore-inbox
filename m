Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264677AbUGZA3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264677AbUGZA3l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 20:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264692AbUGZA3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 20:29:41 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:7102 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S264677AbUGZA3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 20:29:40 -0400
Subject: Re: Future devfs plans
From: Lee Revell <rlrevell@joe-job.com>
To: Ed Sweetman <safemode@comcast.net>
Cc: Jim Gifford <maillist@jg555.com>, "Adam J. Richter" <adam@yggdrasil.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <41044DA6.5080501@comcast.net>
References: <200407261445.i6QEjAS04697@freya.yggdrasil.com>
	 <057601c472a3$9df39ac0$d100a8c0@W2RZ8L4S02>  <41044DA6.5080501@comcast.net>
Content-Type: text/plain
Message-Id: <1090801789.725.3.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 25 Jul 2004 20:29:50 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-07-25 at 20:17, Ed Sweetman wrote:
> Jim Gifford wrote:
> MAKEDEV as distributed at least by debian, doesn't create 
> alsa devices

This has been annoying me too.  I am filing a bug report.  This has no
bearing on devfs vs. udev, it is the job of the distribution to keep the
user space tools in sync with the kernel.

Lee

