Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315287AbSGSO0c>; Fri, 19 Jul 2002 10:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316456AbSGSO0c>; Fri, 19 Jul 2002 10:26:32 -0400
Received: from ns.censoft.com ([208.219.23.2]:58525 "EHLO ns.censoft.com")
	by vger.kernel.org with ESMTP id <S315287AbSGSO0b>;
	Fri, 19 Jul 2002 10:26:31 -0400
Subject: ide-scsi and VIA report
From: Jordan Crouse <jordanc@censoft.com>
To: linux-kernel@vger.kernel.org
Cc: andre@linux-ide.org
In-Reply-To: <20020719131427.GA23103@shaftnet.org>
References: <20020719131427.GA23103@shaftnet.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 19 Jul 2002 08:26:56 -0600
Message-Id: <1027088816.31363.48.camel@cosmic>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an official "me too" report - Previous problems with the VIA
chipset and CD-ROMs were reported here:

http://www.uwsg.iu.edu/hypermail/linux/kernel/0205.1/0207.html

The same problems also happen with the VT8233A chipset on my new
motherboard.  Same symptoms as the previous post, same results with
2.4.19-pre2 and 2.4.19-pre2-ac2.

I haven't tried out 2.5.X yet, I suppose I will try it out just to see
if I get lucky.

Anyway, if Andre and others are working other problems, I would be more
than willing to help with this issue (or at least port it back to the
2.4 tree if a fix exists in the 2.5 branch).

All I need is a little direction on where to start looking.

Thanks,
Jordan 



