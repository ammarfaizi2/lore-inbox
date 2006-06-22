Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932824AbWFVH2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932824AbWFVH2c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 03:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932822AbWFVH2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 03:28:32 -0400
Received: from imo-d06.mx.aol.com ([205.188.157.38]:55694 "EHLO
	imo-d06.mx.aol.com") by vger.kernel.org with ESMTP id S932820AbWFVH2b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 03:28:31 -0400
Content-Transfer-Encoding: 7bit
Date: Thu, 22 Jun 2006 03:28:26 -0400
Message-Id: <8C863E49608F8CC-184C-2F8D@FWM-D28.sysops.aol.com>
From: daveflinux@aim.com
References: <7fc623d50606192355l799ea043hc4eacb190e6be1ce@mail.gmail.com> <1150791472.2891.164.camel@laptopd505.fenrus.org> <8C8631AA59959A1-528-3CB0@FWM-D36.sysops.aol.com>
Cc: linux-net@vger.kernel.org
X-MB-Message-Source: WebUI
X-MB-Message-Type: User
In-Reply-To: <8C8631AA59959A1-528-3CB0@FWM-D36.sysops.aol.com>
X-Mailer: AIM WebMail 17789
Subject: Dropped TCP connections with 2.6.X kernel
Content-Type: text/plain; charset="us-ascii"; format=flowed
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
X-AOL-IP: 205.188.162.4
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hi,

 We're using a 2.6.X kernel,
  and are experiencing intermittent dropped connections when the number 
of concurrent connections exceeds ~ 1000.

  Does anybody have any insight into what might be happening here and/or 
troubleshooting techniques
 for isolating the problem.
 What system resources is TCP dependent on?

 Many thanks,
 Dave


________________________________________________________________________
Check Out the new free AIM(R) Mail -- 2 GB of storage and 
industry-leading spam and email virus protection.

