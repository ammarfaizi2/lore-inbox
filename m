Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbWICWEd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWICWEd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 18:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbWICWEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 18:04:33 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:9793 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750765AbWICWEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 18:04:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=G7S0klDlRDyRx1GuiDAVkZm/g1Ig3MNYS9adqR6lFzxGngBAYspMaJJZktMkjewD8pd+IBrtZ2i1LmNZ9IWHC/ae5+G/aCPH322sZ3CtC/JL7ILadN4eIe5p7sdYNC9u8C1wZhI3uOF9YgeQT9dUYUQ1cjFAEKMjkq0BjB1uJBw=
Message-ID: <a44ae5cd0609031504p5c9673f2jacf60b0068bdebb@mail.gmail.com>
Date: Sun, 3 Sep 2006 15:04:30 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: One of my messages was incorrectly tagged as spam. Can we fix the filter?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an automatically generated Delivery Status Notification

Delivery to the following recipient failed permanently:

    linux-kernel@vger.kernel.org

Technical details of permanent failure:
PERM_FAILURE: SMTP Error (state 12): 550 5.7.1 Content-Policy
accept-into-freezer-1 msg: Bogofilter considers this message SPAM.
BF:<S 1>; S1751542AbWICV1i

  ----- Original message -----

Received: by 10.35.78.9 with SMTP id f9mr8497226pyl;
       Sun, 03 Sep 2006 14:27:37 -0700 (PDT)
Received: by 10.35.64.16 with HTTP; Sun, 3 Sep 2006 14:27:37 -0700 (PDT)
Message-ID: <a44ae5cd0609031427i642ea634p7f5896e0b6fdf51@mail.gmail.com>
Date: Sun, 3 Sep 2006 14:27:37 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: "Sam Ravnborg" <sam@ravnborg.org>, LKML <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
Subject: 2.6.18-rc5-mm1 -- Build error: "make: *** No rule to make
target `include/config/auto.conf'"
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I adjusted some configuration settings and now the build fails.
       --Miles
----------------------
 make all install modules modules_install
scripts/kconfig/conf -s arch/i386/Kconfig

*** Error during writing of the kernel configuration.

make[2]: *** [silentoldconfig] Error 1
make[1]: *** [silentoldconfig] Error 2

<Message truncated>

-- 
VGER BF report: U 0.878254
