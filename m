Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266256AbSKLHVQ>; Tue, 12 Nov 2002 02:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266257AbSKLHVQ>; Tue, 12 Nov 2002 02:21:16 -0500
Received: from johnsl.lnk.telstra.net ([139.130.12.152]:43538 "EHLO
	ns.higherplane.net") by vger.kernel.org with ESMTP
	id <S266256AbSKLHVP>; Tue, 12 Nov 2002 02:21:15 -0500
Date: Tue, 12 Nov 2002 18:26:07 +1100
From: john slee <indigoid@higherplane.net>
To: Russell Greene <rdg12@stanford.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] 18 potential security holes
Message-ID: <20021112072607.GC17478@higherplane.net>
References: <5.1.0.14.2.20021111143426.045c4d90@rdg12.pobox.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20021111143426.045c4d90@rdg12.pobox.stanford.edu>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2002 at 02:35:06PM -0800, Russell Greene wrote:
> You can look at this checker as essentially tracking whether the
> information from an untrusted source (e.g., from copy_from_user) can reach
> a trusting sink (e.g., an array index).

great to see stanford running this again!  it has been extremely helpful
in the past

thanks!

j.

-- 
toyota power: http://indigoid.net/
