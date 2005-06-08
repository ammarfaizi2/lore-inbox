Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262063AbVFHCCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbVFHCCt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 22:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbVFHCCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 22:02:49 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:21354 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262063AbVFHCCr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 22:02:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=O2R8OcVy4XgfNBQ6jDnbF3lUQ+lyTzZ5YqtdO01//4XxOtRihYtbjo4Sf5CPGq8byoZt+6JQxxAhudd7Mx3MjbqCaFE3d2+AbHmpUuiE6R4JWVrMCRAZivkVOJusK/dDZYCtWXTwblRcN6i52tM0eulDvSYD598IMm9kUtAOBpo=
Message-ID: <d73ab4d00506071902172591ad@mail.gmail.com>
Date: Wed, 8 Jun 2005 10:02:47 +0800
From: Blah Blah <gourke@gmail.com>
Reply-To: Blah Blah <gourke@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: boot
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
I confused the bootsect.S which's in the betwenn 2.4.* kernel and 2.6.*.
I mean in 2.4.* , it like "jmp $INITSEG, $go",
but In 2.6.* like 2.6.11,I can not find where use "INITSEG" in
the bootsect.S file.
And i'm greate intersted in the basic things in linux. the boot
must the first thing.
So i want i can get a good document which descripe the bootsect.S
file.and some tips will fine too.

another is where's the latest document for 2.6.* kernel? the faq's only 2.4.*
If you know about it,please tell me.

My kernel is 2.6.11.

Thanks
