Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275570AbRJKCF2>; Wed, 10 Oct 2001 22:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275841AbRJKCFT>; Wed, 10 Oct 2001 22:05:19 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:19628
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S275570AbRJKCFI>; Wed, 10 Oct 2001 22:05:08 -0400
Date: Wed, 10 Oct 2001 19:05:27 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Mike Borrelli <mike@nerv-9.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.10-ac10 ppc fixes
Message-ID: <20011010190527.B11147@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <Pine.LNX.4.21.0110101821330.11511-100000@asuka.nerv-9.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0110101821330.11511-100000@asuka.nerv-9.net>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2001 at 06:28:48PM -0700, Mike Borrelli wrote:

> I didn't mean that Alan should apply it to his tree.  I only merged the
> fixes so that I could compile (it died on my cube) and figured someone
> else might like it.

Can you be more specific about it?  I read the patch and nothing stuck
out as being obvious, but the mm stuff _might_ be needed.

> If I'm propagating bad code, I'll take the patch down and only mess with
> my own stuff so as not to hurt others.

Please do.  I'll try and make -ac nice and happy tonight or tomorrow.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
