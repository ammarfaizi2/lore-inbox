Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280430AbRKST6T>; Mon, 19 Nov 2001 14:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280666AbRKST57>; Mon, 19 Nov 2001 14:57:59 -0500
Received: from a212-113-174-249.netcabo.pt ([212.113.174.249]:12321 "EHLO
	smtp.netcabo.pt") by vger.kernel.org with ESMTP id <S280430AbRKST5u>;
	Mon, 19 Nov 2001 14:57:50 -0500
Content-Type: text/plain; charset=US-ASCII
From: Miguel Maria Godinho de Matos <Astinus@netcabo.pt>
To: linux-kernel@vger.kernel.org
Subject: Fwd: Hp 8xxx Cd writer
Date: Mon, 19 Nov 2001 19:58:33 +0000
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <EXCH01SMTP01aJ6pkNz0000350b@smtp.netcabo.pt>
X-OriginalArrivalTime: 19 Nov 2001 19:57:29.0000 (UTC) FILETIME=[6AF89A80:01C17134]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guys u have been great for answering me but........

Lets see, almost all of u tell to look in my current configuration, so i can 
load it when i am going to recompile the kernel right?

Well the major problem is that in my current configuration, red hat doesn't 
also have the suppor for hp cd writer 8200!

So even if i do so, which i did, it doesn't solve my problem as those modules 
aren't loaded in my current kernel!

John, u say i probably have to say yes to experimental drivers right?, in 
which menu can i state that, cause i am looking the xconfig menus as i am 
typing and i don't seem able to find that option. Also u may be right, but ho 
8200 has been supported since the firs 2.4 kernel, so they may not be 
experimental in the 2.4.14 ( i am probably wrong as i don't understand much 
of the subject ).

Plz guys, can one of u try do make xconfig or make menuconfig as if u were to 
compile the kernel so u can look at the usb menu and check which my problem 
is and how to solve it?

Once again tks for your cooperation.

Gratefull Astinus.



----------  Forwarded Message  ----------

Subject: Hp 8xxx Cd writer
Date: Mon, 19 Nov 2001 14:00:34 +0000
From: Miguel Maria Godinho de Matos <Astinus@netcabo.pt>
To: linux-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Hi, I am crrently runnig linux red hat 7.2 with a 2.4.7 kernel ( i havent
upgraded cause i am a newbie and haven't had he guts to do so ).

However i am trying to configure the kernel 2.4.14 which i actually have even
acomplished to compile.

I have a doubt though! I have an externel cd-writer ( hp 8200 ) which is
supported by the kernel, but in the make xconfig menu, that options appears
in gray ( u can't select it ). As a lot of kernel options need some kind of
pre-selected items, i am asking anyone who  knows what do i have to
pre-select so i can choose the module for hp..... support in my usb kernel
configuration menu.

If i didn't provide enough information plz tell me so!

Crying for help:

Astinus.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

-------------------------------------------------------
