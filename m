Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272245AbRHXQkb>; Fri, 24 Aug 2001 12:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272226AbRHXQkU>; Fri, 24 Aug 2001 12:40:20 -0400
Received: from mx3.port.ru ([194.67.57.13]:53769 "EHLO mx3.port.ru")
	by vger.kernel.org with ESMTP id <S272245AbRHXQkM>;
	Fri, 24 Aug 2001 12:40:12 -0400
From: "Samium Gromoff" <_deepfire@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: [OT] Howl of soul...
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [195.34.27.172]
Reply-To: "Samium Gromoff" <_deepfire@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E15aK0R-000M5f-00@f8.mail.ru>
Date: Fri, 24 Aug 2001 20:40:27 +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

     dear people!

   Sorry for OT, but i want only good to you, lkml
 people...
   If you are to buy a new ide drive, do not buy 
 recent IBM 7200 drives!!!
   The story begins when at February of this year i`ve bought
 perfectly shining ever-fast IBM DTLA-307045...
   After 3 months i`ve hardly regreted about such
 decision: drive started to covers himself with a thick
 layer of logical-not-physical badblocks (ie lowlevel
 reformat doesnt show anything).
   So i went to storagereview and lerned about the matter.
 As i found, these drives had an internal controller bug.

   So i said okay, while restoring 3rd time my reiserfs
 and dumping data to spare drive, and went to
 replace the drive to perfectly new and shining
 IBM IC35L040AVER07-0 also known as 60GXP.

   Now i`am heavily punished for that.
 Badblocks are reapperaing on runtime.
   After they appeared first time i`ve attached large
 fan to the drive, so it was cold(!) to touch. Also
 i stopped to transport the drive between boxes.

   Nevertheless these fscking logical badblocks
 appeared again twice.

   The fact is, that we had bought these drives
 with my friend synchronusly, and now he owns
 quantum drive, after 75gxp and 60gxp...
   Ofcourse he had similar problems.... (btw he use windoze)

   I am _tired_ fixing my poor reiserfs root partition.
   I can say that now i`am expert on how to restore
 badblocked reiserfs partiotions... ;(

   Beware.

---


cheers,


   Samium Gromoff
