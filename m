Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267685AbSLGAoG>; Fri, 6 Dec 2002 19:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267686AbSLGAoG>; Fri, 6 Dec 2002 19:44:06 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:21516 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267685AbSLGAoF>; Fri, 6 Dec 2002 19:44:05 -0500
Date: Sat, 7 Dec 2002 00:51:38 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: acpi-devel@sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Proposed ACPI Licensing change
Message-ID: <20021207005138.A22295@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Grover, Andrew" <andrew.grover@intel.com>,
	acpi-devel@sourceforge.net, linux-kernel@vger.kernel.org
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A57F@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD04C7A57F@orsmsx119.jf.intel.com>; from andrew.grover@intel.com on Fri, Dec 06, 2002 at 04:10:00PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2002 at 04:10:00PM -0800, Grover, Andrew wrote:
> In order to solve this, we are considering releasing the Linux version of
> the interpreter under a dual license. This would allow direct incorporation
> of changes. Any patches submitted against the ACPI core code would
> implicitly be allowed to be used by us in a non-GPL context. This is already
> done elsewhere in the Linux kernel source by the PCMCIA code, for example.
> 
> Comments?

I think that's fine.  Please use a known license for the second option,
i.e. MPL.

