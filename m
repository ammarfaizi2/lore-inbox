Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129792AbQLKJt7>; Mon, 11 Dec 2000 04:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129765AbQLKJtt>; Mon, 11 Dec 2000 04:49:49 -0500
Received: from mail11.voicenet.com ([207.103.0.37]:60889 "HELO voicenet.com")
	by vger.kernel.org with SMTP id <S129688AbQLKJtl>;
	Mon, 11 Dec 2000 04:49:41 -0500
Message-ID: <3A349C12.4000408@voicefx.com>
Date: Mon, 11 Dec 2000 04:19:14 -0500
From: "John O'Donnell" <johnod@voicefx.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.18 i686; en-US; m18) Gecko/20001130
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: YUP- Almost 2.2.18
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,
I was trying to re-install my VMware with the latest 2.2.18 kernel.
It failed to try to re-compile the modules.

--------------------
What is the location of the directory of C header files that match your 
running kernel? [/usr/src/linux/include]

The directory of kernel headers (version 2.2.17) does not match your 
running
kernel (version 2.2.18). Consequently, even if the compilation of the 
module wassuccessful, the module would not load into the running kernel.
-----------------------

Upon inspection of /usr/src/linux/include/linux/version.h
it plainly says 2.2.17.... ????  I changed it to 2.2.18 and all is well.
Johnny O

-- 
=== Never ask a geek why, just nod your head and slowly back away.===
+==============================+====================================+
| John O'Donnell (Sr. Systems Engineer, Net Admin, Webmaster, etc.) |
| Voice FX Corporation (a subsidiary of Student Advantage)          |
| One Plymouth Meeting         |     E-Mail: johnod@voicefx.com     |
| Suite 610                    |           www.voicefx.com          |
| Plymouth Meeting, PA 19462   |         www.campusdirect.com       |
+==============================+====================================+

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
