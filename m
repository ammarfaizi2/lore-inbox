Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbTEYEig (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 00:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbTEYEig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 00:38:36 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:384
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S261324AbTEYEig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 00:38:36 -0400
Date: Sun, 25 May 2003 00:39:21 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>, Keith Owens <kaos@ocs.com.au>,
       James Bottomley <James.Bottomley@steeleye.com>,
       "" <mort@wildopensource.com>, "" <davidm@napali.hpl.hp.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, "" <tomita@cinet.co.jp>
Subject: Re: cpu-2.5.69-bk14-1
In-Reply-To: <20030525042329.GB8284@holomorphy.com>
Message-ID: <Pine.LNX.4.50.0305250037450.17353-100000@montezuma.mastecende.com>
References: <20030520170331.GK29926@holomorphy.com>
 <Pine.LNX.4.50.0305241750570.16144-100000@montezuma.mastecende.com>
 <20030525042329.GB8284@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 May 2003, William Lee Irwin III wrote:

> On Sat, May 24, 2003 at 05:54:10PM -0400, Zwane Mwaikambo wrote:
> > Successfully run for 4 days with various stress loads. on normally 
> > troublesome 3way P133 with CONFIG_NR_CPUS = 72 (255 causes a #SS with 
> > large .configs/kernels)
> 
> To clarify, this is due to bootloading limitations and kernel image size.

My bad, i didn't make that clear, i've seen the same with large NR_IRQS 
arrays.

	Zwane
-- 
function.linuxpower.ca
