Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262758AbVAFMNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262758AbVAFMNt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 07:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262809AbVAFMNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 07:13:48 -0500
Received: from mail.convergence.de ([212.227.36.84]:36029 "EHLO
	email.convergence2.de") by vger.kernel.org with ESMTP
	id S262758AbVAFMNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 07:13:40 -0500
Date: Thu, 6 Jan 2005 13:13:47 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Arne Ahrend <aahrend@web.de>
Cc: linux-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Subject: Re: [linux-dvb-maintainer] Re: PATCH: DVB bt8xx in 2.6.10
Message-ID: <20050106121347.GA12696@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Arne Ahrend <aahrend@web.de>, linux-dvb-maintainer@linuxtv.org,
	linux-kernel@vger.kernel.org
References: <20050104175043.6a8fd195.aahrend@web.de> <20050104181153.GA1416@linuxtv.org> <20050106122409.195100bb.aahrend@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050106122409.195100bb.aahrend@web.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arne Ahrend wrote:
> Johannes Stezenbach <js@linuxtv.org> wrote:
> > This approach has been discussed on the linux-dvb list and was rejected
> > because of the huge #ifdef mess it creates (you just touched bt8xx, it's
> > even worse for saa7146 based cards). The frontend drivers are
> > tiny so I think you can afford to load some that aren't actually
> > used by your hardware.
> 
> Ok, point acknowledged. The following tiny bit of cosmetic might
> be of interest anyway.

Yeah. Patch comitted to linuxtv.org CVS.

Thanks,
Johannes
