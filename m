Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263876AbTJ1JFP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 04:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263888AbTJ1JFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 04:05:15 -0500
Received: from platane.lps.ens.fr ([129.199.121.28]:44941 "EHLO
	platane.lps.ens.fr") by vger.kernel.org with ESMTP id S263876AbTJ1JFL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 04:05:11 -0500
Date: Tue, 28 Oct 2003 10:03:04 +0100
From: =?iso-8859-1?Q?=C9ric?= Brunet <Eric.Brunet@lps.ens.fr>
To: davidm@hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: status of ipchains in 2.6?
Message-ID: <20031028090304.GA19302@lps.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200310280127.h9S1RM5d002140@napali.hpl.hp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In mailing-lists linux-kernel, you wrote:
>I recently discovered that ipchains is rather broken.  I noticed the
>problem on ia64, but suspect that it's likely to affect all 64-bit
>platforms (if not 32-bit platforms).  A more detailed description of
>the problem I'm seeing is here:
>
>       http://tinyurl.com/sm9d

I have just posted less than 12 hours ago a bug-report about a __very__
similar problem occuring on ia32. I trigger it very easily with a rsync
from the client machine. I haven't been able to obtain a complete trace,
though.

In my case, 2.6.0-test4 is working fine.

Éric Brunet
