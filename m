Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261193AbUKCAlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbUKCAlK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 19:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbUKCAkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 19:40:13 -0500
Received: from c-24-10-162-127.client.comcast.net ([24.10.162.127]:10368 "EHLO
	zedd.willden.org") by vger.kernel.org with ESMTP id S261176AbUKCAi5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 19:38:57 -0500
From: Shawn Willden <shawn-lkml@willden.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8 Thinkpad T40, clock running too fast
Date: Tue, 2 Nov 2004 17:38:53 -0700
User-Agent: KMail/1.7
References: <200411021551.53253.shawn-lkml@willden.org> <1099436816.9139.28.camel@cog.beaverton.ibm.com>
In-Reply-To: <1099436816.9139.28.camel@cog.beaverton.ibm.com>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411021738.59657.shawn-lkml@willden.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tuesday 02 November 2004 04:06 pm, john stultz wrote:
> Does this go away if you disable cpufreq in your kernel config?

Nope.

My 2.6.9 config is at http://willden.org/~shawn/config-2.6.9

cpufreq is turned off.  APIC and local APIC are both turned off on the command 
line (noapic and nolapic).

Any ideas?

Thanks,

 Shawn.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD4DBQFBiCij6d8WxFy/CWcRAoBQAJUWR1c2HyOHHbYq+iM8FRh/n8S3AJwKhdOz
35b/Qmv3LxIDboFfXzoH2g==
=5D2Y
-----END PGP SIGNATURE-----
