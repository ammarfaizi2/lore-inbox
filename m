Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273749AbRIXC7w>; Sun, 23 Sep 2001 22:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273751AbRIXC7c>; Sun, 23 Sep 2001 22:59:32 -0400
Received: from johnson.mail.mindspring.net ([207.69.200.177]:21264 "EHLO
	johnson.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S273749AbRIXC7a>; Sun, 23 Sep 2001 22:59:30 -0400
Subject: Re: Preemptible 2.4.10-pre15 compile error
From: Robert Love <rml@ufl.edu>
To: Steve Kieu <haiquy@yahoo.com>
Cc: kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20010924025801.55085.qmail@web10401.mail.yahoo.com>
In-Reply-To: <20010924025801.55085.qmail@web10401.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14.99+cvs.2001.09.22.08.08 (Preview Release)
Date: 23 Sep 2001 23:00:11 -0400
Message-Id: <1001300416.8416.20.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2001-09-23 at 22:58, Steve Kieu wrote:
> Hi,
> 
> Your fix for 2.4.10 compile error is not applied yet?
> I patch 2.4.10 and still have to add the line #include
> <linux/shed.h> in map.c by myself.   :-)
> 
> 
> hope that you integrate this fix soon.

No its not yet merged, it will be with the next patch. Sorry.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

