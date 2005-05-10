Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261701AbVEJPng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261701AbVEJPng (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 11:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261690AbVEJPng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 11:43:36 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:48258 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261701AbVEJPml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 11:42:41 -0400
Subject: Re: Crashing red hat linux
From: Lee Revell <rlrevell@joe-job.com>
To: dipankar das <dipankar_dd@yahoo.com>
Cc: akt-announce@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050510082629.29225.qmail@web40704.mail.yahoo.com>
References: <20050510082629.29225.qmail@web40704.mail.yahoo.com>
Content-Type: text/plain
Date: Tue, 10 May 2005 11:42:39 -0400
Message-Id: <1115739760.12402.14.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-10 at 01:26 -0700, dipankar das wrote:
> Hi
>  Does Red hat like Monta vista allow crashing the
> kernel by writing to  "/dev/crash" if not whats the
> easiest way ?

cat /dev/dsp > /dev/kmem should do it.

Lee

