Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132480AbRAVQOA>; Mon, 22 Jan 2001 11:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132441AbRAVQNu>; Mon, 22 Jan 2001 11:13:50 -0500
Received: from h56s242a129n47.user.nortelnetworks.com ([47.129.242.56]:39597
	"EHLO zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S132178AbRAVQNb>; Mon, 22 Jan 2001 11:13:31 -0500
Message-ID: <28560036253BD41191A10000F8BCBD116BDCC5@zcard00g.ca.nortel.com>
From: "Jonathan Earle" <jearle@nortelnetworks.com>
To: "'Linux Kernel List'" <linux-kernel@vger.kernel.org>
Subject: RE: [OT?] Coding Style
Date: Mon, 22 Jan 2001 11:04:50 -0500
X-Mailer: Internet Mail Service (5.5.2652.35)
X-Orig: <jearle@americasm01.nt.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: profmakx.fmp [mailto:profmakx.fmp@gmx.de]
> 
> So, every good programmer
> should know where to put comments. And it is unnecessary to 
> put comments to
> explain what code does. One should see this as stated in the 
> CodingStyle doc.
> Ok, there are points where a comment is good, but for example 
> at university
> we are to comment on every single line of code ...

WRONG!!!

Not documenting your code is not a sign of good coding, but rather shows
arrogance, laziness and contempt for "those who would dare tamper with your
code after you've written it".  Document and comment your code thoroughly.
Do it as you go along.  I was also taught to comment nearly every line - as
part of the coding style used by a large, international company I worked for
several years ago.  It brings the logic of the programmer into focus and
makes code maintenance a whole lot easier.  It also helps one to remember
the logic of your own code when you revisit it a year or more hence.

Jon
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
