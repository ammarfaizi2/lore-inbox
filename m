Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315176AbSEDDZF>; Fri, 3 May 2002 23:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315428AbSEDDZE>; Fri, 3 May 2002 23:25:04 -0400
Received: from [210.176.202.14] ([210.176.202.14]:15236 "EHLO
	uranus.planet.shaolinmicro.com") by vger.kernel.org with ESMTP
	id <S315176AbSEDDZE>; Fri, 3 May 2002 23:25:04 -0400
Subject: query netdevice interfaces.
From: Joe Wong <joewong@shaolinmicro.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 04 May 2002 11:25:01 +0800
Message-Id: <1020482701.4752.5.camel@star8.staff.shaolinmicro.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

  I know there is a kernel API dev_get_by_name (const char * name) to
return a netdev with a given name. However, is there any way to query a
list of available interface so I don't need to know the name beforehand?

Thx,

- Joe




