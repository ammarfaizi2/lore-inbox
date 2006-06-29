Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932919AbWF2Vst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932919AbWF2Vst (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 17:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932853AbWF2Vsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:48:47 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:46210 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S932541AbWF2VsY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:48:24 -0400
Date: Thu, 29 Jun 2006 14:46:31 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Nix <nix@esperi.org.uk>
Cc: Chris Wright <chrisw@sous-sol.org>, Randy Dunlap <rdunlap@xenotime.net>,
       "Theodore Ts'o" <tytso@mit.edu>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Sam Ravnborg <sam@ravnborg.org>, Justin Forbes <jmforbes@linuxtx.org>,
       linux-kernel@vger.kernel.org, Chris Wedgwood <reviews@ml.cw.f00f.org>,
       torvalds@osdl.org, Dave Jones <davej@redhat.com>,
       Chuck Wolber <chuckw@quantumlinux.com>, stable@kernel.org,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [stable] [PATCH 21/25] kbuild: Fix 100% initramfs bloat in 2.6.17 versus 2.6.16
Message-ID: <20060629214631.GC11588@sequoia.sous-sol.org>
References: <20060627200745.771284000@sous-sol.org> <20060627201655.873643000@sous-sol.org> <20060629213402.GB11588@sequoia.sous-sol.org> <87u063zlhx.fsf@hades.wkstn.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87u063zlhx.fsf@hades.wkstn.nix>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Nix (nix@esperi.org.uk) wrote:
> A difference that makes no difference is no difference :)

No point in digressing from mainline for no good reason ;-)  Either way,
the problem is indeed fixed.

thanks,
-chris
