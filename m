Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282195AbRKWRmN>; Fri, 23 Nov 2001 12:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282194AbRKWRmD>; Fri, 23 Nov 2001 12:42:03 -0500
Received: from a212-113-174-249.netcabo.pt ([212.113.174.249]:50723 "EHLO
	smtp.netcabo.pt") by vger.kernel.org with ESMTP id <S282181AbRKWRlt>;
	Fri, 23 Nov 2001 12:41:49 -0500
Content-Type: text/plain; charset=US-ASCII
From: Miguel Maria Godinho de Matos <Astinus@netcabo.pt>
To: linux-kernel@vger.kernel.org
Subject: Can't patch my 2.4.14 KERNEL!
Date: Fri, 23 Nov 2001 17:42:38 +0000
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <EXCH01SMTP01tFT0D7G00000f88@smtp.netcabo.pt>
X-OriginalArrivalTime: 23 Nov 2001 17:41:20.0948 (UTC) FILETIME=[1015C740:01C17446]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys, i was following your advice about patching the 2.4.14 kernel to 
obtain the ext3 support though i am not being able to do so!!!!

i have the 2.4.14 kernel tree i downloaded from www.kernel.org site in my 
/usr/src/kernel-2.4.14

and i have the  patch-2.4.15-pre9.gz patch in the /usr/src  ( as it is 
recomended in the kernel how to.

i have done the following command:

#zcat  patch-2.4.15-pre9.gz | patch -p0 ( as the example of the how to 
displays!!!! )

and was then presented with the following error:
"
Perhaps you used the wrong -p or --strip option?
The text leading up to this was:
--------------------------
|diff -u --recursive --new-file v2.4.14/linux/CREDITS linux/CREDITS
|--- v2.4.14/linux/CREDITS      Mon Nov  5 15:55:25 2001
|+++ linux/CREDITS      Sun Nov 11 10:09:32 2001
--------------------------
File to patch: /usr/src/linux-2.4.14
patch: **** File /usr/src/linux-2.4.14 is not a regular file -- can't patch"


i would lioke to know ho to apply the pacth!!!! so i can then compile  a 
kernel which supports ext3.

By the way when is the linux kernel 2.4.15 comming out???

Can u guys recomend me some good books about linux programing and stuff??

well, that's all for now. tks, AStinus
