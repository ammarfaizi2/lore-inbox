Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265093AbUIBFTU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265093AbUIBFTU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 01:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267199AbUIBFTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 01:19:20 -0400
Received: from holomorphy.com ([207.189.100.168]:41930 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265093AbUIBFTS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 01:19:18 -0400
Date: Wed, 1 Sep 2004 22:18:45 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Christoph Lameter <clameter@sgi.com>, benh@kernel.crashing.org,
       akpm@osdl.org, davem@redhat.com, raybry@sgi.com, ak@muc.de,
       manfred@colorfullife.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, vrajesh@umich.edu, hugh@veritas.com
Subject: Re: page fault scalability patch final : i386 tested, x86_64 support added
Message-ID: <20040902051845.GW5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"David S. Miller" <davem@davemloft.net>,
	Christoph Lameter <clameter@sgi.com>, benh@kernel.crashing.org,
	akpm@osdl.org, davem@redhat.com, raybry@sgi.com, ak@muc.de,
	manfred@colorfullife.com, linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org, vrajesh@umich.edu, hugh@veritas.com
References: <20040816143903.GY11200@holomorphy.com> <B6E8046E1E28D34EB815A11AC8CA3129027B679F@mtv-atc-605e--n.corp.sgi.com> <B6E8046E1E28D34EB815A11AC8CA3129027B67A9@mtv-atc-605e--n.corp.sgi.com> <B6E8046E1E28D34EB815A11AC8CA3129027B67B4@mtv-atc-605e--n.corp.sgi.com> <Pine.LNX.4.58.0408271616001.14712@schroedinger.engr.sgi.com> <1094012689.6538.330.camel@gaston> <Pine.LNX.4.58.0409010938200.9907@schroedinger.engr.sgi.com> <1094080164.4025.17.camel@gaston> <Pine.LNX.4.58.0409012140440.23186@schroedinger.engr.sgi.com> <20040901215741.3538bbf4.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040901215741.3538bbf4.davem@davemloft.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Sep 2004 21:45:20 -0700 (PDT) Christoph Lameter <clameter@sgi.com> wrote:
>> Where would I find that patch?

On Wed, Sep 01, 2004 at 09:57:41PM -0700, David S. Miller wrote:
> Attached.
> It's held up because it needs to be ported to all platforms
> before we can consider it seriously for inclusion and
> only sparc64 and ppc{,64} are converted.

Nice, I guess I can port this to a few arches. Maybe this is a good
excuse get my new (to me) Octane running, too.


-- wli
