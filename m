Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132374AbRCZHeL>; Mon, 26 Mar 2001 02:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132376AbRCZHeB>; Mon, 26 Mar 2001 02:34:01 -0500
Received: from runyon.cygnus.com ([205.180.230.5]:34756 "EHLO cygnus.com")
	by vger.kernel.org with ESMTP id <S132374AbRCZHdv>;
	Mon, 26 Mar 2001 02:33:51 -0500
From: Michael Elizabeth Chastain <chastain@cygnus.com>
Date: Sun, 25 Mar 2001 23:33:08 -0800
Message-Id: <200103260733.XAA19072@bosch.cygnus.com>
To: esr@thyrsus.com
Subject: Re: [kbuild-devel] Re: CML1 cleanup patch
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Raymond writes:
> (1) 19 of the 39 changes fix things that are outright bugs even in CML1.
>     These should not be allowed to persist in the stable branch.

I think that things that are bugs in CML1, on its own terms, are
worth fixing in 2.4.

Michael
