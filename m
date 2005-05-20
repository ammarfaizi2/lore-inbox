Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261222AbVETApc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbVETApc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 20:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbVETApc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 20:45:32 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:36243 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261222AbVETAp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 20:45:28 -0400
Subject: Re: oops with 2.6.12-rc2
From: Lee Revell <rlrevell@joe-job.com>
To: Narayan Desai <desai@mcs.anl.gov>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <87d5rmhgq3.fsf@topaz.mcs.anl.gov>
References: <87d5rmhgq3.fsf@topaz.mcs.anl.gov>
Content-Type: text/plain
Date: Thu, 19 May 2005 20:45:27 -0400
Message-Id: <1116549928.23977.21.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-19 at 19:40 -0500, Narayan Desai wrote:
> I got the following oops with 2.6.12-rc2. It occurred when I unplugged
> a usb audio device while xmms (presumably) had it opened.

Argh, sorry for the blank message, my mailer is broken.

That bug has been fixed.  Try 2.6.12-rc4.

Lee

