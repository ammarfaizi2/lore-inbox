Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262804AbREaQUF>; Thu, 31 May 2001 12:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262707AbREaQTp>; Thu, 31 May 2001 12:19:45 -0400
Received: from pop.gmx.net ([194.221.183.20]:31572 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S262804AbREaQTf>;
	Thu, 31 May 2001 12:19:35 -0400
Date: Thu, 31 May 2001 18:19:28 +0200
From: Jonas Diemer <diemer@gmx.de>
To: linux-kernel@vger.kernel.org
Message-Id: <20010531181928.635137b7.diemer@gmx.de>
X-Mailer: Sylpheed version 0.4.65 (GTK+ 1.2.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I hope this is the right place for my request. I have heard about a VIA sytem timer bug.

I have a Via KX-133 (for athlon) board and the following problem:

Once the bug is triggered, the system timer goes crazy (i think it is the system timer, i am not sure). following things happen then: X blanks the screen all the time, licq auto-aways or auto-disconnects...

the bug is triggered by high disk throughput (copying large amounts of data from one hd to another) and it often occurs during open-gl.


I have heard, that there is a patch since 2.4.4-ac?, so i upgraded to 2.4.5, but the bug still occurs. do i have to set up something in make menuconfig? if so, what?

-regards, Jonas Diemer

PS: I have NOT subscribed to the list, so please CC me your response.
