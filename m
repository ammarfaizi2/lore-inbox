Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312576AbSDSQgY>; Fri, 19 Apr 2002 12:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312579AbSDSQgX>; Fri, 19 Apr 2002 12:36:23 -0400
Received: from mail.myrio.com ([63.109.146.2]:57338 "HELO mail.myrio.com")
	by vger.kernel.org with SMTP id <S312576AbSDSQgW> convert rfc822-to-8bit;
	Fri, 19 Apr 2002 12:36:22 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: /dev/zero
Date: Fri, 19 Apr 2002 09:35:51 -0700
Message-ID: <A015F722AB845E4B8458CBABDFFE63420FE3D8@mail0.myrio.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: /dev/zero
Thread-Index: AcHnfS5CNpTZiu7bRa24GHRaxP+oeAAQlKvA
From: "Torrey Hoffman" <Torrey.Hoffman@myrio.com>
To: "blesson paul" <blessonpaul@msn.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 19 Apr 2002 16:35:06.0592 (UTC) FILETIME=[29E86E00:01C1E7C0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

blesson paul wrote:
> 		I need some more information about /dev/zero. I 
> need to replace the device 
> driver of /dev/zero(I do not know whether I can name the 
> program controlling 
> the /dev/zero as device driver). How to do the job. 
...

You really ought to get yourself a copy of "Linux Device
Drivers 2nd Edition" by Rubini and Corbet.  

It contains good explanations and lots of examples.

http://www.oreilly.com/catalog/linuxdrive2/

Lucky for you, there is a free online copy:

http://www.xml.com/ldd/chapter/book/index.html

but you probably want to get the paper version too, it is
more convenient in many situations.

Good luck.

Torrey Hoffman
thoffman@arnor.net
torrey.hoffman@myrio.com
