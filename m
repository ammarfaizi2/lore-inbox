Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261676AbSIXOKn>; Tue, 24 Sep 2002 10:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261686AbSIXOKn>; Tue, 24 Sep 2002 10:10:43 -0400
Received: from mms.mms.de ([193.103.160.42]:52232 "EHLO mms.de")
	by vger.kernel.org with ESMTP id <S261676AbSIXOKl>;
	Tue, 24 Sep 2002 10:10:41 -0400
Date: Tue, 24 Sep 2002 16:15:42 +0200 (CEST)
From: Sven Koch <haegar@sdinet.de>
X-X-Sender: haegar@space.comunit.de
To: "Randal, Phil" <prandal@herefordshire.gov.uk>
cc: "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH-RFC] README 1ST - New problem logging macros (2.5.38)
In-Reply-To: <0EBC45FCABFC95428EBFC3A51B368C9501AF48@jessica.herefordshire.gov.uk>
Message-ID: <Pine.LNX.4.44.0209241613330.7015-100000@space.comunit.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Sep 2002, Randal, Phil wrote:

> You'll have to ask RedHat et al why they persist in backporting
> security patches to "old" releases of Apache (etc) instead of
> releasing the new versions.  The effect is the same, with
> vulnerabilities being squashed, but the version numbers reported
> suggesting otherwise.

Because every new version gives you some new problems/incompatibilities,
which must not happen in a running production-environment.

And testing every security-update 4 weeks in the lab before putting
it into production would be worse.

c'ya
sven

-- 

The Internet treats censorship as a routing problem, and routes around it.
(John Gilmore on http://www.cygnus.com/~gnu/)

