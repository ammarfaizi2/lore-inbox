Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbWH0Rqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbWH0Rqi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 13:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932210AbWH0Rqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 13:46:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:54221 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932208AbWH0Rqh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 13:46:37 -0400
X-Authenticated: #2360897
Date: Sun, 27 Aug 2006 19:46:34 +0200
From: Bernhard Walle <Bernhard.Walle@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Sintax
Message-ID: <20060827174634.GE4340@mail1.bwalle.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20060827173335.GA4062@windows95>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060827173335.GA4062@windows95>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

* Andrew Brukhov <pingved@gmail.com> [2006-08-27 19:33]:
> Why linux developers did't use gnu indent wich orginizing code
> correspondence given template? It's stupid to send pathes fixes
> style & etc.

Well, maybe because automatically indented code is not as readable as
hand-indented?

Beside, there's scripts/Lindent in the kernel sources which contains
the basic settings for GNU indent.


Regards,
  Bernhard
