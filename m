Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264768AbTIDHZB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 03:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264772AbTIDHZB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 03:25:01 -0400
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:4751 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S264768AbTIDHYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 03:24:55 -0400
Date: Wed, 3 Sep 2003 13:48:22 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22 with CONFIG_M686: networking broken
Message-ID: <20030903114822.GI27875@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.30.0309031227100.10173-100000@swamp.bayern.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0309031227100.10173-100000@swamp.bayern.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Sep 2003, Peter Daum wrote:

> I tried lots of different options until I eventually found out,
> that the single setting that makes all the difference is the
> processor type: Independently of any other settings, all kernels
> with "CONFIG_M686" exhibit these problems; when I change this to
> "CONFIG_MPENTIUM4" and recompile, everything seems to work.

Which compiler version are you using?

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
