Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262865AbUKRSqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262865AbUKRSqp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 13:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262859AbUKRSoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 13:44:25 -0500
Received: from mx1.redhat.com ([66.187.233.31]:40321 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262862AbUKRSmm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 13:42:42 -0500
Date: Thu, 18 Nov 2004 13:41:27 -0500
From: Alan Cox <alan@redhat.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       "John W. Linville" <linville@tuxdriver.com>,
       linux-kernel@vger.kernel.org, alan@redhat.com
Subject: Re: [patch 2.6.10-rc2] oss: AC97 quirk facility
Message-ID: <20041118184127.GA11856@devserv.devel.redhat.com>
References: <20041117163016.A5351@tuxdriver.com> <20041117145644.005e54ff.akpm@osdl.org> <419CE98B.2090304@pobox.com> <Pine.LNX.4.53.0411181936050.8260@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0411181936050.8260@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2004 at 07:36:21PM +0100, Jan Engelhardt wrote:
> >> Dumb question: why not just use the ALSA driver?
> >
> >Until we actually remove the OSS drivers, it's sorta silly to leave them
> >broken.
> 
> It's just as silly to fix something we're removing anyway.

A lot of people are still using OSS. Thats likel to continue for some time
when people are using new kernels on older distributions

