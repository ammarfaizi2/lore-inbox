Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbTEYEKb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 00:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261311AbTEYEKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 00:10:31 -0400
Received: from holomorphy.com ([66.224.33.161]:6300 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261305AbTEYEKa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 00:10:30 -0400
Date: Sat, 24 May 2003 21:23:29 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>, Keith Owens <kaos@ocs.com.au>,
       James Bottomley <James.Bottomley@steeleye.com>, mort@wildopensource.com,
       davidm@napali.hpl.hp.com, "Nakajima, Jun" <jun.nakajima@intel.com>,
       tomita@cinet.co.jp
Subject: Re: cpu-2.5.69-bk14-1
Message-ID: <20030525042329.GB8284@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Zwane Mwaikambo <zwane@linuxpower.ca>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	LSE <lse-tech@lists.sourceforge.net>, Keith Owens <kaos@ocs.com.au>,
	James Bottomley <James.Bottomley@steeleye.com>,
	mort@wildopensource.com, davidm@napali.hpl.hp.com,
	"Nakajima, Jun" <jun.nakajima@intel.com>, tomita@cinet.co.jp
References: <20030520170331.GK29926@holomorphy.com> <Pine.LNX.4.50.0305241750570.16144-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0305241750570.16144-100000@montezuma.mastecende.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 May 2003, William Lee Irwin III wrote:
> Extended cpumasks for larger systems. Now featuring bigsmp, Summit,
>> and Voyager updates in addition to PC-compatible, NUMA-Q, and SN2
>> bits from SGI.

On Sat, May 24, 2003 at 05:54:10PM -0400, Zwane Mwaikambo wrote:
> Successfully run for 4 days with various stress loads. on normally 
> troublesome 3way P133 with CONFIG_NR_CPUS = 72 (255 causes a #SS with 
> large .configs/kernels)

To clarify, this is due to bootloading limitations and kernel image size.


-- wli
