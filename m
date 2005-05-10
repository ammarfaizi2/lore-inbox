Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261777AbVEJUmn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbVEJUmn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 16:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbVEJUmD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 16:42:03 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:61336 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261777AbVEJUe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 16:34:26 -0400
Subject: Re: High res timer?
From: Lee Revell <rlrevell@joe-job.com>
To: Andre Eisenbach <int2str@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <7f800d9f050510132762f0ee7@mail.gmail.com>
References: <7f800d9f050510132762f0ee7@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 10 May 2005 16:34:24 -0400
Message-Id: <1115757264.14061.24.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-10 at 13:27 -0700, Andre Eisenbach wrote:
> Hello!
> 
> We're currently using pth_usleep() as a timer for a userspace audio
> application. However, it doesn't seem very accurate and reliable. Is
> there a better (more accurate) timer that we can call form a userspace
> application?

Why don't you just clock off the sound card?

Lee

