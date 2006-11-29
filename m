Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967413AbWK2PVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967413AbWK2PVr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 10:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967415AbWK2PVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 10:21:47 -0500
Received: from nz-out-0506.google.com ([64.233.162.227]:35654 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S967413AbWK2PVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 10:21:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=tj9G8dwRmqEA1+Ys2bNhS2kNnAnens5uSvlKW+82SOKRSi3g+SW16n4fokHf71KHJCzobX9fJZ+dcrI2t0H+5X/QtC/jEEi4hHdKyW0fFInYVwRsBhbnl/eldVrShIJHMmlptLSY81PbFHYEoRD/730EOonwvtKhfr+QPD1Iajc=
Message-ID: <9956e0d30611290721o3d8ce45bwe9abb3156c994fa4@mail.gmail.com>
Date: Wed, 29 Nov 2006 17:21:45 +0200
From: "Vladimir Pouzanov" <farcaller@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Using poll for sysfs attribute files
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm looking for a way to implement polling for sysfs attribute files.
There seem to be sysfs_poll API but I have no idea how to use it
correctly.

Any hint, example of usage or comment wold be deeply appreciated.

-- 
Sincerely,
Vladimir "Farcaller" Pouzanov
