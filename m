Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280246AbRKIWkw>; Fri, 9 Nov 2001 17:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280255AbRKIWkn>; Fri, 9 Nov 2001 17:40:43 -0500
Received: from [63.146.149.19] ([63.146.149.19]:44787 "EHLO
	mailessentials.wagweb.com") by vger.kernel.org with ESMTP
	id <S280246AbRKIWkc> convert rfc822-to-8bit; Fri, 9 Nov 2001 17:40:32 -0500
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Message-ID: <3BEC5B59.7D29E401@wagweb.com>
Date: Fri, 09 Nov 2001 17:40:25 -0500
From: "Madhav Diwan" <mdiwan@wagweb.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: <linux-kernel@vger.kernel.org>, "Madhav Diwan" <mdiwan@wagweb.com>
Subject: RedHat 2.4.7 & 2.4.9-13 Poweroff failure
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-OriginalArrivalTime: 09 Nov 2001 22:41:26.0453 (UTC) FILETIME=[AA6B4E50:01C1696F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi 

I Just put RedHats 7.2 on my Compaq Presario 1200-xl106 laptop .. Im
running an AMD 450 with 151 meg ram

I was running Mandrake 8 on it before .. I had upgraded to kernel 2.4.8
on Mandrake and when Redhat released its newest I swithed OS for the
laptop .. 

 Mandrake's kernel 2.4.8 had no problems releasing my laptops battery.

RedHats newest kernels  2.4.7, and 2.4.9-13 seem to have the same
problem that RedHat had in 2.4.2 .. they will do everything  including
shutting down the backlight and .. it sound like they release the drive
as well.. but they do not let go of the battery.. on a laptop that is a
BAD thing.

 any hints?

is this patchable ?.. is this a consistent error or just a mistake that
got back into the mix after 2.4.2 were fixed in 2.4.3 ?

yes i know.. compile and use linus kernels.. i just want to know if i
should scrap the laptops os and not bother..:)

Thanks for any help


Madhav Diwan


Note: The information contained in this message may be privileged and confidential and protected from disclosure.  If the reader of this message is not the intended recipient, or an employee or agent responsible for delivering this message to the intended recipient, you are hereby notified that any dissemination, distribution or copying of this communication is strictly prohibited. If you have received this communication in error, please notify us immediately by replying to the message and deleting it from your computer.  Thank you.  Wagner Weber & Williams
