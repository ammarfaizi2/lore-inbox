Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316390AbSGRFGO>; Thu, 18 Jul 2002 01:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316545AbSGRFGN>; Thu, 18 Jul 2002 01:06:13 -0400
Received: from adsl-216-62-200-99.dsl.austtx.swbell.net ([216.62.200.99]:22452
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S316390AbSGRFGN>; Thu, 18 Jul 2002 01:06:13 -0400
Subject: Re: [RFC] Groups beyond 32
From: Austin Gonyou <austin@digitalroadkill.net>
To: Tim Hockin <thockin@hockin.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200207172342.g6HNgWJ05647@www.hockin.org>
References: <200207172342.g6HNgWJ05647@www.hockin.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1026968835.15472.1.camel@UberGeek.digitalroadkill.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 18 Jul 2002 00:07:15 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ahh....good to know. Thanks for all the information guys. We'll hold off
till this is done I think, then come back around and see what it buys
us. THX much.

On Wed, 2002-07-17 at 18:42, Tim Hockin wrote:
> > (glibc has #define NGROUPS NGROUPS_MAX).
> > 
> > > 3. Is there any true advantage to supporting more than 32 groups, or
> > > creating "meta-groups" to get around the problem? 
> > 
> > There probably is.
> 
> We have patches to fix all this groups stuff, and I have every intention of
> submitting them Real Soon Now.  Our offices are moving, so stuff is hither
> and thither.
> 
> Tim
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Austin Gonyou <austin@digitalroadkill.net>
