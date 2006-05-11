Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751770AbWEKN0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751770AbWEKN0R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 09:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751771AbWEKN0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 09:26:17 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:62940 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751770AbWEKN0R convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 09:26:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=taIba1HhEmMCv9fSp38cPE1WM3sRCHVu9y2wPSBzYJySbrwKDTRceS3ADPU2bhcMQQhVILtKVfZIvCt4eRDu1hm922K0K9xXoupTA+IuqU0byQlnV+Jz5O3ff+NSg6xhkzlTrpN107FgBJKZKBaEOWwkbl/RYvrC+ZZ1V+cpoQc=
Message-ID: <bae323a50605110626v196bf76cj5fa3d63fe7d789a0@mail.gmail.com>
Date: Thu, 11 May 2006 15:26:14 +0200
From: "Carlos Ojea Castro" <nuudoo.fb@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: geode sc1200 2D graphics acceleration
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I am drawing some graphics (a group of lines) using DirectFb in a
geode sc1200 (kernel 2.4).
I discovered that when I disable 2D hardware acceleration (by changing
'/root/.directfbrc' and '/etc/directfbrc') it is FASTER than drawing
with 2D hardware acceleration enabled.

Can't figure why. Any ideas?
