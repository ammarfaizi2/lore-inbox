Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131315AbRAWPsD>; Tue, 23 Jan 2001 10:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131325AbRAWPrx>; Tue, 23 Jan 2001 10:47:53 -0500
Received: from h56s242a129n47.user.nortelnetworks.com ([47.129.242.56]:45461
	"EHLO zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S131315AbRAWPrl>; Tue, 23 Jan 2001 10:47:41 -0500
Message-ID: <28560036253BD41191A10000F8BCBD116BDCCD@zcard00g.ca.nortel.com>
From: "Jonathan Earle" <jearle@nortelnetworks.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: RE: [OT?] Coding Style
Date: Tue, 23 Jan 2001 10:41:49 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2652.35)
Content-Type: multipart/alternative;
              boundary="----_=_NextPart_001_01C08552.FFC336D0"
X-Orig: <jearle@americasm01.nt.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C08552.FFC336D0
Content-Type: text/plain;
	charset="ISO-8859-1"

I prefer descriptive variable and function names - like comments, they help
to make code so much easier to read.

One thing I wonder though... why do people prefer 'some_function_name()'
over 'SomeFunctionName()'?  I personally don't like the underscore character
- it's an odd character to type when you're trying to get the name typed in,
and the shifted character, I find, is easier to input.

Cheers!
Jon

> -----Original Message-----
> From: Steve Underwood [mailto:steveu@coppice.org]

Some people still seem to be living in the age of K&R C, with 6 or 7
character variable names that demand some explanation. Maybe some day
they will awake to the expressive power of long (and well chosen) names.

------_=_NextPart_001_01C08552.FFC336D0
Content-Type: text/html;
	charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3DISO-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
5.5.2652.35">
<TITLE>RE: [OT?] Coding Style</TITLE>
</HEAD>
<BODY>

<P><FONT SIZE=3D2>I prefer descriptive variable and function names - =
like comments, they help to make code so much easier to read.</FONT>
</P>

<P><FONT SIZE=3D2>One thing I wonder though... why do people prefer =
'some_function_name()' over 'SomeFunctionName()'?&nbsp; I personally =
don't like the underscore character - it's an odd character to type =
when you're trying to get the name typed in, and the shifted character, =
I find, is easier to input.</FONT></P>

<P><FONT SIZE=3D2>Cheers!</FONT>
<BR><FONT SIZE=3D2>Jon</FONT>
</P>

<P><FONT SIZE=3D2>&gt; -----Original Message-----</FONT>
<BR><FONT SIZE=3D2>&gt; From: Steve Underwood [<A =
HREF=3D"mailto:steveu@coppice.org">mailto:steveu@coppice.org</A>]</FONT>=

</P>

<P><FONT SIZE=3D2>Some people still seem to be living in the age of =
K&amp;R C, with 6 or 7</FONT>
<BR><FONT SIZE=3D2>character variable names that demand some =
explanation. Maybe some day</FONT>
<BR><FONT SIZE=3D2>they will awake to the expressive power of long (and =
well chosen) names.</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C08552.FFC336D0--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
