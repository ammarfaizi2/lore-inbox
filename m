Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265454AbUFRRLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265454AbUFRRLp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 13:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266217AbUFRRLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 13:11:45 -0400
Received: from holomorphy.com ([207.189.100.168]:5766 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265454AbUFRRLf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 13:11:35 -0400
Date: Fri, 18 Jun 2004 10:11:26 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Brian M. Carlson" <sandals@crustytoothpaste.ath.cx>
Cc: debian-legal@lists.debian.org, debian-kernel@lists.debian.org,
       debian-devel@lists.debian.org, linux-kernel@vger.kernel.org
Subject: Re: How long is it acceptable to leave *undistributable* files in the kernel package?
Message-ID: <20040618171126.GF1863@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Brian M. Carlson" <sandals@crustytoothpaste.ath.cx>,
	debian-legal@lists.debian.org, debian-kernel@lists.debian.org,
	debian-devel@lists.debian.org, linux-kernel@vger.kernel.org
References: <o0_liB.A.TFG.4fu0AB@murphy> <20040618113543.B1892@links.magenta.com> <20040618155113.GD1863@holomorphy.com> <200406181650.34830.sandals@crustytoothpaste.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406181650.34830.sandals@crustytoothpaste.ath.cx>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2004 at 04:50:08PM +0000, Brian M. Carlson wrote:
> If it's undistributable, it obviously doesn't belong in main. So please
> remove the undistributable stuff. Second, if it's non-free, it doesn't
> belong in the kernel, which is in main. So remove anything that is
> non-free from the kernel-source. It's really not rocket science, and I
> don't know why people insist upon talking about collective versus
> derivative works, because none of this stuff belongs in main anyway.
> If you need help in determining whether something is free or not, please send 
> a message to debian-legal (preferably in a new thread) asking that question.

I have a blacklist of things to remove already I'm stuck carrying and
continuing to remove from what we call "pristine" upstream sources, but
I didn't see any specific suggestion for additions to it or removals
from it. So at the moment I don't have anything to go on as far as what
this thread tells me to do. I'm bothered somewhat by the fact that this
all sounds alarming, but doesn't seem to have anything specific to be
done about it, which is why I asked the participants in this discussion
to try to come to some kind of actual conclusion I could act on.


-- wli
