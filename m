Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316838AbSGQXjl>; Wed, 17 Jul 2002 19:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316847AbSGQXjl>; Wed, 17 Jul 2002 19:39:41 -0400
Received: from adsl-64-166-241-227.dsl.snfc21.pacbell.net ([64.166.241.227]:28131
	"EHLO www.hockin.org") by vger.kernel.org with ESMTP
	id <S316838AbSGQXjk>; Wed, 17 Jul 2002 19:39:40 -0400
From: Tim Hockin <thockin@hockin.org>
Message-Id: <200207172342.g6HNgWJ05647@www.hockin.org>
Subject: Re: [RFC] Groups beyond 32
To: hpa@zytor.com (H. Peter Anvin)
Date: Wed, 17 Jul 2002 16:42:32 -0700 (PDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <ah4v23$39o$1@cesium.transmeta.com> from "H. Peter Anvin" at Jul 17, 2002 04:36:35 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> (glibc has #define NGROUPS NGROUPS_MAX).
> 
> > 3. Is there any true advantage to supporting more than 32 groups, or
> > creating "meta-groups" to get around the problem? 
> 
> There probably is.

We have patches to fix all this groups stuff, and I have every intention of
submitting them Real Soon Now.  Our offices are moving, so stuff is hither
and thither.

Tim
