Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932445AbVIGVtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbVIGVtu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 17:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbVIGVtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 17:49:50 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:59331 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932445AbVIGVtu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 17:49:50 -0400
Date: Thu, 8 Sep 2005 07:49:47 +1000
From: Nathan Scott <nathans@sgi.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: linux-xfs@oss.sgi.com, xfs-masters@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [xfs-masters] warning: "__BIG_ENDIAN" is not defined
Message-ID: <20050908074947.C4583139@wobbly.melbourne.sgi.com>
References: <200509072145.j87LjnwI014068@agluck-lia64.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200509072145.j87LjnwI014068@agluck-lia64.sc.intel.com>; from tony.luck@intel.com on Wed, Sep 07, 2005 at 02:45:49PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On Wed, Sep 07, 2005 at 02:45:49PM -0700, Luck, Tony wrote:
> I see a lot (90) of warnings when building xfs on ia64.  The

Christoph has a patch pending (slightly different approach to
yours) that should resolve this.

cheers.

--
Nathan
