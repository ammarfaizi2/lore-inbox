Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279551AbRJXMpQ>; Wed, 24 Oct 2001 08:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279552AbRJXMpH>; Wed, 24 Oct 2001 08:45:07 -0400
Received: from mail6.speakeasy.net ([216.254.0.206]:6404 "EHLO
	mail6.speakeasy.net") by vger.kernel.org with ESMTP
	id <S279551AbRJXMpA>; Wed, 24 Oct 2001 08:45:00 -0400
Content-Type: text/plain; charset=US-ASCII
From: safemode <safemode@speakeasy.net>
To: f5ibh <f5ibh@db0bm.ampr.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.12-ac, lm-sensors broken ??
Date: Wed, 24 Oct 2001 08:45:34 -0400
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <200110241238.OAA02419@db0bm.ampr.org>
In-Reply-To: <200110241238.OAA02419@db0bm.ampr.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011024124503Z279551-17408+4359@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 24 October 2001 08:38, f5ibh wrote:
> Hi,
>
> I use the lm-sensors on my system, it works fine with 2.2.20pre and 2.4.13
> but not with the ac tree, is there any reason for that ? I compile the i2c
> and lm-sensors package as modules outside the kernel. The .config are the
> same for both the kernels. The various modules (w83781d i2c-proc i2c-isa
> i2c-core) loads fine with both systems.

I use it quite nicely on 2.4.12-ac3   the latest i2c stack is already in the 
ac branch, you need not compile it on your own.  lm sensors version 2.6.1 and 
up is supported.  Just compile and install it.  (make;make install). 
