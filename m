Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751815AbWEFFCP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751815AbWEFFCP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 01:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751604AbWEFFCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 01:02:15 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:2229 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751146AbWEFFCO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 01:02:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=d1u0SOWWZGErS2XCB7ek8J3SxB2L6nbSqXl3UHthpJauvULa8fJiouCYnyQimX7rTBm3U8lug9/CrfS+E7LGmR22T2E1bJQwf6xlavNQYVfzCurRhT/nGOIJ+kB8BuLu6Tg0xt8ADdWVkWy2asbofujwyhEKoWZWU4ZH/0nWPsM=
Message-ID: <844f6ea60605052202i224bf7cew9018afa7e6959e11@mail.gmail.com>
Date: Sat, 6 May 2006 10:32:14 +0530
From: "C K Kashyap" <ckkashyap@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Booting vmlinux with GRUB on x86
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like kernel 2.6 generates a kernel that can be loaded by GRUB by
just adding the multiboot signature...However, it does'nt quite work!
... Has anyone tried it? Just want to do away with the overhead of
bzImage etc!!
--
Regards,
Kashyap
