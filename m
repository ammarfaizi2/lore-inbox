Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161031AbVKXMNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161031AbVKXMNF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 07:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161033AbVKXMNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 07:13:04 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:22684 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1161031AbVKXMNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 07:13:02 -0500
Subject: Re: Oops in 2.6.15-rc1
From: Lee Revell <rlrevell@joe-job.com>
To: Brian Marete <bgmarete@gmail.com>
Cc: Ricardo Cerqueira <v4l@cerqueira.org>,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
       linux-kernel@vger.kernel.org
In-Reply-To: <6dd519ae0511240209y712549bep6ba626134bb6f502@mail.gmail.com>
References: <6dd519ae0511240209y712549bep6ba626134bb6f502@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 24 Nov 2005 06:32:31 -0500
Message-Id: <1132831951.3473.18.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-24 at 10:09 +0000, Brian Marete wrote:
> I have not seen such an oops with Kernel 2.6.14 (Of course, I am aware
> that the -rcn kernels are for testing :) My main motivation in
> installing 2.6.15-rc5 was actually to test drive the new ALSA
> capability for saa7134 driver) 

You could have done that without even rebooting, much less building a
new kernel, just download the latest ALSA from
http://www.alsa-project.org and follow the install instructions.  ALSA
detects your kernel sources and patches itself to build against that
kernel.  It will even work with a 2.2 kernel.

Lee

