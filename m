Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280624AbRKBJmS>; Fri, 2 Nov 2001 04:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280627AbRKBJmI>; Fri, 2 Nov 2001 04:42:08 -0500
Received: from web20502.mail.yahoo.com ([216.136.226.137]:15925 "HELO
	web20502.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S280624AbRKBJlz>; Fri, 2 Nov 2001 04:41:55 -0500
Message-ID: <20011102094154.55827.qmail@web20502.mail.yahoo.com>
Date: Fri, 2 Nov 2001 10:41:54 +0100 (CET)
From: =?iso-8859-1?q?willy=20tarreau?= <wtarreau@yahoo.fr>
Subject: Re: bonding problems?
To: Sam James <sam.james@adelphia.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> if you unplug the cable to one of the bonded
interfaces it
> never appears to figure out that that part of the
channel is
> down

this is the standard behaviour. Check the following
URL for
an updated version which handles this situation among
others
cases of failure :

http://sf.net/projects/bonding/

Regards,
Willy


___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Courrier : http://courrier.yahoo.fr
