Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261782AbVDTSSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbVDTSSQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 14:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbVDTSSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 14:18:16 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:45747 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261782AbVDTSSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 14:18:12 -0400
Subject: Re: linux with disabled interrupts
From: Lee Revell <rlrevell@joe-job.com>
To: Francesco Oppedisano <francesco.oppedisano@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <875fe4a505042011054ac36e00@mail.gmail.com>
References: <875fe4a505042011054ac36e00@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 20 Apr 2005 14:18:11 -0400
Message-Id: <1114021091.25679.1.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-04-20 at 18:05 +0000, Francesco Oppedisano wrote:
> Hi,
> i'd like to know how much time does linux kernel run with disabled
> interrupts. So i would like to remap the instructions capable of
> disabling interrupt to other ones which count how much this time is...
> Does already exist a patch or tool capable to give me a magnitude
> order of the time spent by the kernel with disables interrupts?

http://people.redhat.com/mingo/realtime-preempt

Lee

