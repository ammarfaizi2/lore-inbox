Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267576AbUJLT1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267576AbUJLT1g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 15:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267607AbUJLT1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 15:27:36 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:49387 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267576AbUJLT1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 15:27:32 -0400
Subject: Re: Problem compiling linux-2.6.8.1......
From: Lee Revell <rlrevell@joe-job.com>
To: Stephan <support@bbi.co.bw>
Cc: root@chaos.analogic.com, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <001501c4b07d$96a31fd0$0200060a@STEPHANFCN56VN>
References: <006901c4b05a$3dddd570$0200060a@STEPHANFCN56VN>
	 <20041012141123.GA18579@stusta.de>
	 <001401c4b068$7cb74750$0200060a@STEPHANFCN56VN>
	 <Pine.LNX.4.61.0410121048110.3470@chaos.analogic.com>
	 <000c01c4b07b$c10060f0$0200060a@STEPHANFCN56VN>
	 <Pine.LNX.4.61.0410121256510.12380@chaos.analogic.com>
	 <001501c4b07d$96a31fd0$0200060a@STEPHANFCN56VN>
Content-Type: text/plain
Message-Id: <1097608879.1553.82.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 12 Oct 2004 15:21:19 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-12 at 13:04, Stephan wrote:
> gcc (GCC) 3.2.3 20030502
> 

I think there is a bug in this exact version that screw up inlining,
don't remember where it was reported.  Try a different GCC version.

Lee

