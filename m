Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751019AbVHaTuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbVHaTuF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 15:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbVHaTuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 15:50:05 -0400
Received: from orb.pobox.com ([207.8.226.5]:45276 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S1751019AbVHaTuD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 15:50:03 -0400
Date: Wed, 31 Aug 2005 14:49:58 -0500
From: Rodney Gordon II <meff@pobox.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, ck list <ck@vds.kolivas.org>
Subject: Re: [ck] 2.6.13-ck1
Message-ID: <20050831194958.GA7021@spherenet.spherevision.org>
Mail-Followup-To: Con Kolivas <kernel@kolivas.org>,
	linux-kernel@vger.kernel.org, ck list <ck@vds.kolivas.org>
References: <200508291703.26529.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508291703.26529.kernel@kolivas.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2005 at 05:03:24PM +1000, Con Kolivas wrote:
> These are patches designed to improve system responsiveness and interactivity. 
> It is configurable to any workload but the default ck* patch is aimed at the 
> desktop and ck*-server is available with more emphasis on serverspace.
> 
> 
> Apply to 2.6.13
> http://ck.kolivas.org/patches/2.6/2.6.13/2.6.13-ck1/patch-2.6.13-ck1.bz2
> or development version:
> http://ck.kolivas.org/patches/2.6/2.6.13/2.6.13-ck1/patch-2.6.13-ck1+.bz2
> 
> or server version:
> http://ck.kolivas.org/patches/2.6/2.6.13/2.6.13-ck1/patch-2.6.13-ck1-server.bz2

I am having odd lockup problems with just the non-+ 'stable' ck lately..
Trying a large copy will often lock my disk I/O up and I have to do a hard
reboot. Nothing shows in logs..

Is anyone having similar problems?

-r

-- 
Rodney Gordon II (meff)             |         meff <at> pobox <dot> com
GPG Key ID: 7FF4B2BC                |                   AIM ID: mefforz
