Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135920AbREDIkx>; Fri, 4 May 2001 04:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135946AbREDIko>; Fri, 4 May 2001 04:40:44 -0400
Received: from femail2.sdc1.sfba.home.com ([24.0.95.82]:44434 "EHLO
	femail2.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S135920AbREDIkd>; Fri, 4 May 2001 04:40:33 -0400
Message-ID: <3AF26AF3.DE530356@home.com>
Date: Fri, 04 May 2001 01:40:19 -0700
From: Seth Goldberg <bergsoft@home.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: Linux-kernel@vger.kernel.org
Subject: Idea for Athlon/Duron failure testing...
In-Reply-To: <20010503150346.A18141@debian-home.lcisp.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

   Do you think it would be a good idea to check the fast_copy
athlon mmx routine by putting in code that basically compares
the source & destination copies and checks if they are equal?
I realize that will slow down the system, but for testing,
it seems like a good idea...

 --S
