Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263211AbTJKCKD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 22:10:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263212AbTJKCKD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 22:10:03 -0400
Received: from holomorphy.com ([66.224.33.161]:55430 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263211AbTJKCKA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 22:10:00 -0400
Date: Fri, 10 Oct 2003 19:13:07 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: --- <grundig@teleline.es>
Cc: "Frederick, Fabian" <Fabian.Frederick@prov-liege.be>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.7 "thoughts"] V0.3
Message-ID: <20031011021307.GH727@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	--- <grundig@teleline.es>,
	"Frederick, Fabian" <Fabian.Frederick@prov-liege.be>,
	linux-kernel@vger.kernel.org
References: <D9B4591FDBACD411B01E00508BB33C1B01F24E98@mesadm.epl.prov-liege.be> <20031011040435.299bd3bc.grundig@teleline.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031011040435.299bd3bc.grundig@teleline.es>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 11, 2003 at 04:04:35AM +0200, --- wrote:
> On thing me (as a user) would like to see is more user limits.
> In particular; a (small) per-user mlock limit would be nice so a normal user
> can mlock some memory to avoid buffer underruns without needing to give suid
> permissions to cdrecord (which is what people uses now and guarantees you'll
> have to update your cdrecord copy some day due to unavoidable security issues).
> I wonder if this is a good wishlist item or just a stupid idea...

cdrecord doesn't make sense because it requires privilege for device
access anyway.


-- wli
