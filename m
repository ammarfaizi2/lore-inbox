Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311865AbSCQH0K>; Sun, 17 Mar 2002 02:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311869AbSCQH0B>; Sun, 17 Mar 2002 02:26:01 -0500
Received: from mail02.vsnl.net ([203.197.12.5]:18685 "EHLO mail02.vsnl.net")
	by vger.kernel.org with ESMTP id <S311865AbSCQHZl>;
	Sun, 17 Mar 2002 02:25:41 -0500
Date: Sun, 17 Mar 2002 12:55:44 +0530
From: Ashwin D <ashwinds@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: i810 and the AC tree
Message-Id: <20020317125544.21f12fb2.ashwinds@yahoo.com>
X-Mailer: Sylpheed version 0.7.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Linux Amateur  Alert!!

I was trying to get Quake 3 going on my i810 kobian motherboard with the 2.4.19-pre2-ac2 kernel and was troubled by the display limiting itself to 1/4 (top) of my 14 inch monitor at a startx depth of 16. At a depth of 24, the display was sized correctly but q3 was too slow -I believe Q3 will only work at a depth of 16. 

I switched to the 2.4.18 kernel and this problem disappeared - so I presume this is a bug attached to the AC tree alone- maybe associated with XFree 4.2 merge in 2.4.18pre9-ac3. The problem also exists in the 2.4.19-pre3-ac3 kernel.

Iam using Mandrake 8.1 with XFree 4.1.x and fluxbox+rox as wm. 

Hope someone can fix this before Marcelo merges it into his tree. For any further info, please mail me directly/CC since Iam not subscribed to LKML.

Regards,
ashwin 
