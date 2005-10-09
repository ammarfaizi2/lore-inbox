Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932226AbVJIGHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbVJIGHV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 02:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932227AbVJIGHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 02:07:21 -0400
Received: from nproxy.gmail.com ([64.233.182.203]:25798 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932226AbVJIGHV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 02:07:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ltzW0+JS7XAN9mQeuRipS5zeoasURZKHYjt/Q5IzehJfpi/CvwTUpRCXpj3RpBTxmol+4iApVgpu9SqixGOcDg2tuMmDTfyE2WMrxeSb2hV2sJjEVhtmIpaBJ7Hqf3gCCcoi77aOIVcYerbTs8XO2TWtUwZa1XRWf6wMxOecASM=
Message-ID: <2cd57c900510082307q1841ce8dob1dce3b24edf4ad0@mail.gmail.com>
Date: Sun, 9 Oct 2005 14:07:19 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: webmaster@kernel.org
Subject: "stable" vs "security stable"
Cc: lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       security@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I find the kernel.org first page inconvenient for some people somehow
since the security stable came.

Now on the kernel.org page, we have 2.6.13.3 and 2.6.14-rc3. If one
wants to get 2.6.14-rc3, he shouldn't get 2.6.14-rc3 Full, but
2.6.14-rc3 Patch and 2.6.13 Full, which isn't there unfortunately. I
suggest we name 2.6.13.3 "security stable", and 2.6.13 "stable".

Fix the 1st line as:
s/The latest stable version/The latest security stable version/

Add a line below:
+The latest stable version of the Linux kernel is:  	2.6.13

And adjust the F,V on the right accordingly.

The rational behind is:
2.6.13.3 is security stable, which we suggest users to use. However
the stable is still 2.6.13.

Comments?
--
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
