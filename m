Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932541AbWARN2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932541AbWARN2I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 08:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932540AbWARN2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 08:28:07 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:1456 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932522AbWARN2G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 08:28:06 -0500
Date: Wed, 18 Jan 2006 14:27:49 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Lincoln Dale (ltd)" <ltd@cisco.com>
cc: Michael Tokarev <mjt@tls.msk.ru>, NeilBrown <neilb@suse.de>,
       linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: RE: [PATCH 000 of 5] md: Introduction
In-Reply-To: <26A66BC731DAB741837AF6B2E29C1017D47EA0@xmb-hkg-413.apac.cisco.com>
Message-ID: <Pine.LNX.4.61.0601181427090.19392@yvahk01.tjqt.qr>
References: <26A66BC731DAB741837AF6B2E29C1017D47EA0@xmb-hkg-413.apac.cisco.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>personally, I think this this useful functionality, but my personal
>preference is that this would be in DM/LVM2 rather than MD.  but given
>Neil is the MD author/maintainer, I can see why he'd prefer to do it in
>MD. :)

Why don't MD and DM merge some bits?



Jan Engelhardt
-- 
