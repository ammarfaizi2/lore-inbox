Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286004AbRLHWNd>; Sat, 8 Dec 2001 17:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286002AbRLHWNX>; Sat, 8 Dec 2001 17:13:23 -0500
Received: from a212-113-174-249.netcabo.pt ([212.113.174.249]:58661 "EHLO
	smtp.netcabo.pt") by vger.kernel.org with ESMTP id <S286004AbRLHWNO>;
	Sat, 8 Dec 2001 17:13:14 -0500
Content-Type: text/plain; charset=US-ASCII
From: Miguel Maria Godinho de Matos <Astinus@netcabo.pt>
To: linux-kernel@vger.kernel.org
Subject: SCSI????
Date: Sat, 8 Dec 2001 22:13:59 +0000
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <EXCH01SMTP01xavjrRZ0000bfbc@smtp.netcabo.pt>
X-OriginalArrivalTime: 08 Dec 2001 22:12:13.0243 (UTC) FILETIME=[636770B0:01C18035]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have recently compiled the kernel 2.4.16 in a P2 running red hat 7.2.

I have a hp82xxxx so i made sure i selected the SCSI support, as well as SCSI 
cdrom support and tape support ( don't know why though ) and disk support all 
that stuff, but i compiled them as an integrated part of the kernel and not 
as modules!!!!

I Also selected usb mass storage support and stuff but that doesn't matter 
for now!!

Well the problem is:

whenever linux boots it trys to load the Scsi modules for the new kernel but 
it [ fails ], i figure this is because my previous had scsi as module and now 
it isn't a module but a integrated part of the kernel, so i turned off  the 
scsi from the service manager. ( don't know if i am right though ).

second, how do i make sure scsi support is actually running???

third, if scsi is running and if i have the usb mass storage built into the 
kernel, why doesn't my cd-rw appear listed  as a scsi connected device as it 
should??

regards, Astinus.
