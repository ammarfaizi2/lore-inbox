Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262140AbVDLUbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262140AbVDLUbu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 16:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262124AbVDLUas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 16:30:48 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:59808 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262140AbVDLS2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 14:28:54 -0400
Subject: Re: [PATCH] ppc64: very basic desktop g5 sound support (#2)
From: Lee Revell <rlrevell@joe-job.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrea Arcangeli <andrea@suse.de>
In-Reply-To: <1113282436.21548.42.camel@gaston>
References: <1113282436.21548.42.camel@gaston>
Content-Type: text/plain
Date: Tue, 12 Apr 2005 14:28:53 -0400
Message-Id: <1113330533.31159.43.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-12 at 15:07 +1000, Benjamin Herrenschmidt wrote:
> Hi !
> 
> (Andrew: This is an update of the previous patch, it fixes a problem
> with headphone beeing incorrectly muted on some models).
> 
> This patch hacks the current PowerMac Alsa driver to add some basic
> support of analog sound output to some desktop G5s. It has severe
> limitations though:

Um... why in the heck are you posting this here instead of alsa-devel?

Lee

