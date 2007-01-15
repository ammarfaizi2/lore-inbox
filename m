Return-Path: <linux-kernel-owner+w=401wt.eu-S932340AbXAONro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbXAONro (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 08:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbXAONrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 08:47:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:42632 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932340AbXAONrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 08:47:43 -0500
X-Authenticated: #5039886
Date: Mon, 15 Jan 2007 14:47:40 +0100
From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: jeff@garzik.org, linux-kernel@vger.kernel.org, htejun@gmail.com
Subject: Re: SATA exceptions with 2.6.20-rc5
Message-ID: <20070115134739.GA2255@atjola.homenet>
Mail-Followup-To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Mikael Pettersson <mikpe@it.uu.se>, jeff@garzik.org,
	linux-kernel@vger.kernel.org, htejun@gmail.com
References: <20070114224409.GA17199@atjola.homenet> <17835.9143.973552.427040@alkaid.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17835.9143.973552.427040@alkaid.it.uu.se>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2007.01.15 07:48:23 +0100, Mikael Pettersson wrote:
> Notice how the problems started exactly at the point the
> "NVRM" NVIDIA module (whatever it is) was loaded ...

That's not the reason. Yeah, I should not have sent a log of a run with
the nvidia module loaded, but the same thing happens without it. For the
bisection kernels I did not even build the nvidia module and did the
testing at the console.

Björn
