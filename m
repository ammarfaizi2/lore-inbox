Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269693AbRHWSVM>; Thu, 23 Aug 2001 14:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269786AbRHWSVC>; Thu, 23 Aug 2001 14:21:02 -0400
Received: from adsl-209-76-109-63.dsl.snfc21.pacbell.net ([209.76.109.63]:2176
	"EHLO adsl-209-76-109-63.dsl.snfc21.pacbell.net") by vger.kernel.org
	with ESMTP id <S269693AbRHWSUu>; Thu, 23 Aug 2001 14:20:50 -0400
Date: Thu, 23 Aug 2001 11:20:25 -0700
From: Wayne Whitney <whitney@math.berkeley.edu>
Message-Id: <200108231820.f7NIKPk01202@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
To: Paul <set@pobox.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [OOPS] repeatable 2.4.8-ac7, 2.4.7-ac6 just run xdos
In-Reply-To: <20010823140545.A224@squish.home.loc>
In-Reply-To: <20010819004703.A226@squish.home.loc.suse.lists.linux.kernel> <3B831CDF.4CC930A7@didntduck.org.suse.lists.linux.kernel> <oupn14sny4f.fsf@pigdrop.muc.suse.de> <3B839E47.874F8F64@didntduck.org> <20010822141058.A18043@gruyere.muc.suse.de> <3B83A17C.CB8ABC53@didntduck.org> <20010822152203.A18873@gruyere.muc.suse.de> <20010822155226.A228@squish.home.loc> <20010823153419.A8743@gruyere.muc.suse.de> <20010823153419.A8743@gruyere.muc.suse.de> <20010823140545.A224@squish.home.loc>
Reply-To: whitney@math.berkeley.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In mailing-lists.linux-kernel, you wrote:

> 	Good! I have beaten on this a bit, and it is holding up
> for me, and there are no problems using dosemu. My thanks to
> everyone who responded to this bug.

FWIW, "me too" on 2.4.8-ac9.  dos -X would lock the machine after
about 15 minutes (Alt-Sysrq-B would work), with this patch it is gone.

Wayne

