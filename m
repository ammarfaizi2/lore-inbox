Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266926AbRGMEp4>; Fri, 13 Jul 2001 00:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266928AbRGMEpp>; Fri, 13 Jul 2001 00:45:45 -0400
Received: from patan.Sun.COM ([192.18.98.43]:31633 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id <S266926AbRGMEpi>;
	Fri, 13 Jul 2001 00:45:38 -0400
Message-ID: <3B4E7EA1.F904DC43@sun.com>
Date: Thu, 12 Jul 2001 21:52:49 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: SOMAXCONN - bump up or sysctl?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hey all,

We have a request to bump up SOMAXCONN.  Are there are repurcussions to
doing so?  Would it be better to make it a sysctl?

-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
