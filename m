Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbTDXXDb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 19:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262763AbTDXXDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 19:03:31 -0400
Received: from almesberger.net ([63.105.73.239]:59146 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S262196AbTDXXDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 19:03:30 -0400
Date: Thu, 24 Apr 2003 20:15:22 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Daniel Phillips <phillips@arcor.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flame Linus to a crisp!
Message-ID: <20030424201522.G1425@almesberger.net>
References: <Pine.LNX.4.44.0304232012400.19176-100000@home.transmeta.com> <20030424182945.7065812EFF1@mx12.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030424182945.7065812EFF1@mx12.arcor-online.net>; from phillips@arcor.de on Thu, Apr 24, 2003 at 08:31:06PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> Open source + Linux + DRM could be used to solve the Quake client-side 
> cheating problem:

Yes, but in return you'd be excluded from playing Quake unless
you're running one of those signed kernels or modules.

So, if I, say, want to test some TCP fix, new VM feature, file
system improvement, etc., none of the applications that rely on
DRM would work. This doesn't only affect developers, but also
their potential testers.

Given that most users will just run a distribution's kernel, with
all the right signatures, companies will not perceive the few
cases in which their use of DRM causes problems as very important,
so they will use DRM.

Oh, maybe some developers could be granted the privilege of being
able to sign their own kernels or modules. So if you're part of
this circle, you'd be fine, right ? No, even this doesn't work,
because if you'd leak such a key, you'd certainly get sued for
damages. And I don't think many people would feel overly pleased
with the idea of being responsible for the safekeeping of the key
to a multi-million lawsuit. (And besides, this may turn them into
targets for key theft/robbery/extortion.)

(There are of course uses of such signatures that would not have
those problems. E.g. signatures that prove trustworthiness to the
local user, instead of a remote party.)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
