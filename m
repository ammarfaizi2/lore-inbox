Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262894AbVCDNNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262894AbVCDNNa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 08:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262871AbVCDNMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 08:12:42 -0500
Received: from f38.mail.ru ([194.67.57.76]:34317 "EHLO f38.mail.ru")
	by vger.kernel.org with ESMTP id S262894AbVCDNJz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 08:09:55 -0500
From: se go <ass22@inbox.ru>
To: linux-kernel@vger.kernel.org
Subject: debugging TCP routines using User Mode Linux
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [194.85.70.42]
Date: Fri, 04 Mar 2005 16:09:49 +0300
Reply-To: se go <ass22@inbox.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1D7CYv-000Mec-00.ass22-inbox-ru@f38.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

i'm dealing with some tcp modifications in linux kernel and surely i need debugging

for these purposes i use User Mode Linux and it works ok but the problem debugging namely tcp (or any other network protocol, i suppose) is different tcp-timeouts while I tracing the code (tracing looks like much slower execution of a program...)...

i need the idea how i can "freeze" all the time variables in linux tcp  protocol to be independent from time while debugging code...

maybe there's some standard solution..? i don't know

sorry for probably silly question..

i'm not subscribed to maillist so i need to be personally CC'ed...

thanks,

Serge Goodenko,
Moscow Institute of Physics and Technology
Moscow, Russia
