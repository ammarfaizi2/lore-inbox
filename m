Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268819AbUHUCVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268819AbUHUCVw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 22:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268821AbUHUCVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 22:21:51 -0400
Received: from gw.goop.org ([64.81.55.164]:18883 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S268819AbUHUCVt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 22:21:49 -0400
Subject: Re: banias with different (unusual?) model_name
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: matthias.brill@akamail.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       cpufreq list <cpufreq@www.linux.org.uk>
In-Reply-To: <20040820093344.GA2923@akamail.com>
References: <20040820093344.GA2923@akamail.com>
Content-Type: text/plain
Date: Fri, 20 Aug 2004 19:19:31 -0700
Message-Id: <1093054772.3043.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 (1.5.9.1-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-20 at 11:33 +0200, matthias brill wrote:
> hi jeremy
> 
> i've found a pentium-m banias which reports "Mobile Genuine Intel(R)
> processor       1400MHz" in /proc/cpuinfo.  this (strange?) signature
> prevents speedstep-centrino.c from working properly.

Yeah, there seem to be a few of these around.  I'm just not certain that
they're identical to "normal" Banias as far as operating points go.

	J

