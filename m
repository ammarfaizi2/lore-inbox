Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265374AbUAAKYG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 05:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265378AbUAAKYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 05:24:06 -0500
Received: from mail5.bluewin.ch ([195.186.1.207]:5292 "EHLO mail5.bluewin.ch")
	by vger.kernel.org with ESMTP id S265374AbUAAKYE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 05:24:04 -0500
Date: Thu, 1 Jan 2004 11:23:54 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Thomas Molina <tmolina@cablespeed.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0 performance problems
Message-ID: <20040101102354.GA4063@k3.hellgate.ch>
Mail-Followup-To: Thomas Molina <tmolina@cablespeed.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20031230012551.GA6226@k3.hellgate.ch> <Pine.LNX.4.58.0312292031450.6227@localhost.localdomain> <20031230132145.B32120@hexapodia.org> <20031230194051.GD22443@holomorphy.com> <20031230222403.GA8412@k3.hellgate.ch> <Pine.LNX.4.58.0312301921510.3193@localhost.localdomain> <20031231101741.GA4378@k3.hellgate.ch> <20031231112119.GB3089@suse.de> <20031231210354.GA9804@k3.hellgate.ch> <Pine.LNX.4.58.0312312014480.3069@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312312014480.3069@localhost.localdomain>
X-Operating-System: Linux 2.6.0-test11 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Dec 2003 20:27:34 -0500, Thomas Molina wrote:
> 2.5.39 won't compile for me "out of the box".  I thought it might have 
> been the toolset, but I was running RH8 and it has gcc 3.2.  Was there a 

I used gcc 2.95. 3.2 won't work with older kernels, not sure when
exactly problems were fixed, though.

Roger
