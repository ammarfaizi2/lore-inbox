Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129319AbQLSBvj>; Mon, 18 Dec 2000 20:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129415AbQLSBv3>; Mon, 18 Dec 2000 20:51:29 -0500
Received: from acct2.voicenet.com ([207.103.26.205]:63135 "HELO voicenet.com")
	by vger.kernel.org with SMTP id <S129319AbQLSBvR>;
	Mon, 18 Dec 2000 20:51:17 -0500
Message-ID: <3A3EB7F0.3050905@voicefx.com>
Date: Mon, 18 Dec 2000 20:20:48 -0500
From: "John O'Donnell" <johnod@voicefx.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.18 i686; en-US; m18) Gecko/20001130
X-Accept-Language: en
MIME-Version: 1.0
To: kees <kees@schoen.nl>, linux-kernel@vger.kernel.org
Subject: Re: old binary works not with 2.2.18
In-Reply-To: <Pine.LNX.4.21.0012182026170.8049-100000@schoen3.schoen.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kees wrote:

> Hi,
> 
> I have an old 4GL application (from SCO3.2v4) that is a neat database
> tool. Under 2.2.17 with iBCS this works well:

I am just curious.  Did you re-compile the iBCS2 module after upgrading
to 2.2.18 to did you force the module to load up...

With Slackware and kernel upgrades this is a regular procedure with me
otherwise chaos ensues  :-)
Johnny O

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
