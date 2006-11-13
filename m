Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755325AbWKMSwJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755325AbWKMSwJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 13:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755327AbWKMSwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 13:52:09 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:59091 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1755325AbWKMSwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 13:52:07 -0500
Subject: Re: [RFC] Pushing device/driver binding decisions to userspace
From: Lee Revell <rlrevell@joe-job.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Ben Collins <ben.collins@ubuntu.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1163404727.15249.99.camel@laptopd505.fenrus.org>
References: <1163374762.5178.285.camel@gullible>
	 <1163404727.15249.99.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Mon, 13 Nov 2006 13:51:26 -0500
Message-Id: <1163443887.5313.27.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-13 at 08:58 +0100, Arjan van de Ven wrote:
> Now; there is a second issue. If the choice for one or the other is
> consistent, we should consider fixing the kernel drivers to just not
> advertise the b0rked one.. (this assumes that both drivers are in the
> kernel and both are open source) 

Unfortunately it becomes political quickly.  For example the old OSS
i810_audio driver is still in the kernel even though the ALSA driver
supports more hardware and provides more functionality because some
people consider the ALSA driver bloated.

Lee

