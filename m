Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbQLSSTo>; Tue, 19 Dec 2000 13:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129745AbQLSSTe>; Tue, 19 Dec 2000 13:19:34 -0500
Received: from acct2.voicenet.com ([207.103.26.205]:24027 "HELO voicenet.com")
	by vger.kernel.org with SMTP id <S129431AbQLSSTY>;
	Tue, 19 Dec 2000 13:19:24 -0500
Message-ID: <3A3F9F84.5AE17AB9@voicefx.com>
Date: Tue, 19 Dec 2000 12:48:52 -0500
From: "John O'Donnell" <johnod@voicefx.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kees <kees@schoen.nl>, linux-kernel@vger.kernel.org
Subject: Re: old binary works not with 2.2.18
In-Reply-To: <Pine.LNX.4.21.0012191803250.6506-100000@schoen3.schoen.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kees wrote:
> 
> Hello,
> 
> Yep, *After* I build a new kernel I _always_ build a new iBCS module.
> 
> I have an old utility 'hd' (hexdump) from SCO3.2v4.2 that also needs iBCS
> but has a slightly different format, *that* works under 2.2.18
> 
> Kees

Kudos!!!  I use the same utility but from 5.0.5  :-)  (huge GRIN)
Sorry that wasnt the solution...

-- 
<SomeLamer> what's the difference between chattr and chmod?
<SomeGuru> SomeLamer: man chattr > 1; man chmod > 2; diff -u 1 2 | less
	-- Seen on #linux on irc
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
