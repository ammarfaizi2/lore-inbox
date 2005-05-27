Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261752AbVE0OEG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbVE0OEG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 10:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbVE0OEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 10:04:06 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:38354 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261752AbVE0ODC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 10:03:02 -0400
Subject: Re: weird X problem - priority inversion?
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050523075508.GC9287@elte.hu>
References: <1113428938.16635.13.camel@mindpipe>
	 <20050523075508.GC9287@elte.hu>
Content-Type: text/plain
Date: Fri, 27 May 2005 10:03:01 -0400
Message-Id: <1117202581.13829.20.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-23 at 09:55 +0200, Ingo Molnar wrote:
> does this still occur with the latest tree? (.47-05 or later)

I'll retest with the latest version.  It's still present in
2.6.12-rc4-RT-V0.7.47-01.

Do you think the kernel could be involved?  It's looking more like an X
problem to me.

Lee

