Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266310AbSLCVeC>; Tue, 3 Dec 2002 16:34:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266316AbSLCVeC>; Tue, 3 Dec 2002 16:34:02 -0500
Received: from lennier.cc.vt.edu ([198.82.162.213]:24331 "EHLO
	lennier.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S266310AbSLCVeA>; Tue, 3 Dec 2002 16:34:00 -0500
X-WebMail-UserID: sitan
Date: Tue, 3 Dec 2002 16:41:28 -0500
From: "Tan, SiewYeen" <sitan@vt.edu>
To: linux-kernel@vger.kernel.org
X-EXP32-SerialNo: 00002964
Subject: Routing table update
Message-ID: <3DEF8ED9@zathras>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: WebMail (Hydra) SMTP v3.61.08
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello. I have questions about updated retrieving routing table.

I deleted a route/entry from the routing table using 'route del...' command, 
and used 'route' to display the routing table. The routing table does not show 
the deleted entry, but the file /proc/net/route still has the deleted entry.

I would like to read the file /proc/net/route to plot a network topology, but 
this file doesn't seems to be updated whenever i deleted an entry.

What file i should i access this updated routing table? or what should i do to 
get the updated table? Any suggestion?
btw, it works fine with adding an entry....

Thank you very much
tan

