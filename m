Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264448AbRFIJKm>; Sat, 9 Jun 2001 05:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264446AbRFIJKc>; Sat, 9 Jun 2001 05:10:32 -0400
Received: from ncc1701.cistron.net ([195.64.68.38]:32528 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S264445AbRFIJKX>; Sat, 9 Jun 2001 05:10:23 -0400
From: dth@trinity.hoho.nl (Danny ter Haar)
Subject: www.bzimage.org: bad intermediate patch 2.4.5-ac9-ac10
Date: Sat, 9 Jun 2001 09:10:21 +0000 (UTC)
Organization: Holland Hosting
Message-ID: <9fsp5t$g6f$1@voyager.cistron.net>
X-Trace: voyager.cistron.net 992077821 16591 195.64.82.84 (9 Jun 2001 09:10:21 GMT)
X-Complaints-To: abuse@cistron.nl
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We had for an hour or so a bad intermediate diff
going from kernel 2.4.5-ac9 to ac10.
The size of the patch was 800+ kilobyte.
The new "good" one is about 163 kilobyte.
If you try to apply the wrong patch, it complains
about scsidrivers beeing reversed.

Sorry for the troubles.

Danny


-- 
Holland Hosting
www.hoho.nl      info@hoho.nl

