Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131439AbQKAUxO>; Wed, 1 Nov 2000 15:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131418AbQKAUxF>; Wed, 1 Nov 2000 15:53:05 -0500
Received: from Cantor.suse.de ([194.112.123.193]:24075 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S131373AbQKAUw4>;
	Wed, 1 Nov 2000 15:52:56 -0500
Date: Wed, 1 Nov 2000 21:52:55 +0100
From: Andi Kleen <ak@suse.de>
To: Michael Rothwell <rothwell@holly-springs.nc.us>
Cc: linux-kernel@vger.kernel.org
Subject: Re: working userspace nfs v3 for linux?
Message-ID: <20001101215255.A23849@gruyere.muc.suse.de>
In-Reply-To: <3A007608.BBB79151@holly-springs.nc.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A007608.BBB79151@holly-springs.nc.us>; from rothwell@holly-springs.nc.us on Wed, Nov 01, 2000 at 02:59:05PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2000 at 02:59:05PM -0500, Michael Rothwell wrote:
> Is there a working userspace nfs v3 server for linux?

Yes, just install user mode linux and use its v3 knfsd server.

-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
