Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273757AbRIXDa1>; Sun, 23 Sep 2001 23:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273769AbRIXDaR>; Sun, 23 Sep 2001 23:30:17 -0400
Received: from mtiwmhc26.worldnet.att.net ([204.127.131.51]:54952 "EHLO
	mtiwmhc26.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S273757AbRIXDaF>; Sun, 23 Sep 2001 23:30:05 -0400
Date: Sun, 23 Sep 2001 23:30:22 -0400
From: khromy <khromy@lnuxlab.ath.cx>
To: Taral <taral@taral.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10 problems with X + USB mouse
Message-ID: <20010923233022.A30991@lnuxlab.ath.cx>
In-Reply-To: <20010923222036.A1685@taral.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010923222036.A1685@taral.net>; from taral@taral.net on Sun, Sep 23, 2001 at 10:20:36PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 23, 2001 at 10:20:36PM -0500, Taral wrote:
> I have XFree86 4.1.0 and a USB mouse with input core support. On 2.4.9
> everything is happy. On 2.4.10 the mouse clicks randomly and jumps to
> the bottom left corner a lot. This doesn't affect gpm though, only X.
> 
> Any ideas? I've backed down to 2.4.9 for now.

I had this problem too.  I used NetMousePS/2 in XF86Config but changing
it to IMPS/2 fixed it.

5 button Microsoft IntelliMouse?

-- 
L1:	khromy		;khromy at lnuxlab.ath.cx
