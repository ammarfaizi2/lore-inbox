Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261425AbUDUVu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbUDUVu5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 17:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbUDUVu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 17:50:57 -0400
Received: from main.gmane.org ([80.91.224.249]:18859 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261425AbUDUVuz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 17:50:55 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Marcos B <marcosnospam@free.fr>
Subject: atkbd.c help !
Date: Wed, 21 Apr 2004 23:49:44 +0200
Message-ID: <c66q9j$jvs$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: montreuil-4-82-66-118-57.fbx.proxad.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20040312 Debian/1.4.1-0jds1
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I cannot run X.

after startx, I have this message in dmesg:

atkbd.c: unknown key released (transalted set 2, code 0x7a on 
isa00060/serio0).
atbkd.c: This is an XFree86 bug. It shouldn't access hardware directly.

Anyone knows if it is actually a XFree86 bug ?
And how to fix it ?

/var/log/XFree86.0.log gives me no error.

I've googled around and it seems that many people have this message, but 
they can start X. Not me !

Please help ! I need my gnome !
If it is not the right place to ask this question, please tell me where 
I can get more information.

Thanks

I'm using Debian Sid, kernel 2.6.4, XFree86 4.3.0-7


