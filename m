Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275126AbRJ2NjB>; Mon, 29 Oct 2001 08:39:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275110AbRJ2Niw>; Mon, 29 Oct 2001 08:38:52 -0500
Received: from web20508.mail.yahoo.com ([216.136.226.143]:268 "HELO
	web20508.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S275278AbRJ2Nip>; Mon, 29 Oct 2001 08:38:45 -0500
Message-ID: <20011029133921.74466.qmail@web20508.mail.yahoo.com>
Date: Mon, 29 Oct 2001 14:39:21 +0100 (CET)
From: =?iso-8859-1?q?willy=20tarreau?= <wtarreau@yahoo.fr>
Subject: Re: Ethernet NIC dual homing
To: Laurent Deniel <deniel@worldnet.fr>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

> Does someone know if there is some work in the area
of NIC
> dual homing ?

I have implemented this for 2.2 kernel a while ago,
and Chad
Tindel has completed the port to 2.4. Some other
contributors
have added features such as XOR distribution. You can
take
a look at it, kernel 2.4 patches are on :

   http://sf.net/projects/bonding/

and 2.2 patches are on :

 
http://www-miaif.lip6.fr/willy/linux-patches/bonding/

Regards,
Willy


___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Courrier : http://courrier.yahoo.fr
