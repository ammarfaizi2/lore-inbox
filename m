Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130870AbRAWQdJ>; Tue, 23 Jan 2001 11:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131206AbRAWQdA>; Tue, 23 Jan 2001 11:33:00 -0500
Received: from blackdog.wirespeed.com ([208.170.106.25]:14863 "EHLO
	blackdog.wirespeed.com") by vger.kernel.org with ESMTP
	id <S130870AbRAWQcp>; Tue, 23 Jan 2001 11:32:45 -0500
Message-ID: <3A6DB234.1090507@redhat.com>
Date: Tue, 23 Jan 2001 10:32:52 -0600
From: Joe deBlaquiere <jadb@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22 i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Harrold <mharrold@cas.org>
CC: Jonathan Earle <jearle@nortelnetworks.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [OT?] Coding Style
In-Reply-To: <200101231600.LAA24562@mah21awu.cas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Too bad we can't just do a "Prince" and invent unpronouncable symbols to 
use as function names... or perhaps just use something from the chinese 
fonts ;o)...

Mike Harrold wrote:

>> This message is in MIME format. Since your mail reader does not understand
>> this format, some or all of this message may not be legible.
>> 
>> ------_=_NextPart_001_01C08552.FFC336D0
>> Content-Type: text/plain;
>> 	charset="ISO-8859-1"
>> 
>> I prefer descriptive variable and function names - like comments, they help
>> to make code so much easier to read.
>> 
>> One thing I wonder though... why do people prefer 'some_function_name()'
>> over 'SomeFunctionName()'?  I personally don't like the underscore character
>> - it's an odd character to type when you're trying to get the name typed in,
>> and the shifted character, I find, is easier to input.
>> 
> 
> 
> For exactly the reverse of that reason. Typing capital letters is a heck
> of a lot more difficult that addint an underscore.
> 
> Then there is reasability.
> 
>   void ThisIsMyDumbassFunctionName
> 
> if MUCH more difficult to read than
> 
>   void this_is_my_clear_and_easy_function_name
> 
> Regards,
> 
> /Mike
> 
> 
>> Cheers!
>> Jon
>> 
>> 
>>> -----Original Message-----
>>> From: Steve Underwood [mailto:steveu@coppice.org]
>> 
>> Some people still seem to be living in the age of K&R C, with 6 or 7
>> character variable names that demand some explanation. Maybe some day
>> they will awake to the expressive power of long (and well chosen) names.
>> 
>> ------_=_NextPart_001_01C08552.FFC336D0
>> Content-Type: text/html;
>> 	charset="ISO-8859-1"
>> Content-Transfer-Encoding: quoted-printable
>> 
>> <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
>> <HTML>
>> <HEAD>
>> <META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
>> charset=3DISO-8859-1">
>> <META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
>> 5.5.2652.35">
>> <TITLE>RE: [OT?] Coding Style</TITLE>
>> </HEAD>
>> <BODY>
>> 
>> <P><FONT SIZE=3D2>I prefer descriptive variable and function names - =
>> like comments, they help to make code so much easier to read.</FONT>
>> </P>
>> 
>> <P><FONT SIZE=3D2>One thing I wonder though... why do people prefer =
>> 'some_function_name()' over 'SomeFunctionName()'?&nbsp; I personally =
>> don't like the underscore character - it's an odd character to type =
>> when you're trying to get the name typed in, and the shifted character, =
>> I find, is easier to input.</FONT></P>
>> 
>> <P><FONT SIZE=3D2>Cheers!</FONT>
>> <BR><FONT SIZE=3D2>Jon</FONT>
>> </P>
>> 
>> <P><FONT SIZE=3D2>&gt; -----Original Message-----</FONT>
>> <BR><FONT SIZE=3D2>&gt; From: Steve Underwood [<A =
>> HREF=3D"mailto:steveu@coppice.org">mailto:steveu@coppice.org</A>]</FONT>=
>> 
>> </P>
>> 
>> <P><FONT SIZE=3D2>Some people still seem to be living in the age of =
>> K&amp;R C, with 6 or 7</FONT>
>> <BR><FONT SIZE=3D2>character variable names that demand some =
>> explanation. Maybe some day</FONT>
>> <BR><FONT SIZE=3D2>they will awake to the expressive power of long (and =
>> well chosen) names.</FONT>
>> </P>
>> 
>> </BODY>
>> </HTML>
>> ------_=_NextPart_001_01C08552.FFC336D0--
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> Please read the FAQ at http://www.tux.org/lkml/
>> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/


-- 
Joe deBlaquiere
Red Hat, Inc.
307 Wynn Drive
Huntsville AL, 35805
voice : (256)-704-9200
fax   : (256)-837-3839

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
