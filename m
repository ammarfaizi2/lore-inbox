Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130329AbRATXLS>; Sat, 20 Jan 2001 18:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130887AbRATXLH>; Sat, 20 Jan 2001 18:11:07 -0500
Received: from omega.cisco.com ([171.69.63.141]:43500 "EHLO cisco.com")
	by vger.kernel.org with ESMTP id <S130329AbRATXKx>;
	Sat, 20 Jan 2001 18:10:53 -0500
Message-Id: <4.3.2.7.2.20010121100103.02820730@171.69.63.141>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Sun, 21 Jan 2001 10:09:30 +1100
To: kaih@khms.westfalen.de (Kai Henningsen)
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
Cc: linux-kernel@vger.kernel.org,
        dean gaudet <dean-list-linux-kernel@arctic.org>
In-Reply-To: <7uDh9dHmw-B@khms.westfalen.de>
In-Reply-To: <Pine.LNX.4.30.0101181840380.16292-100000@twinlark.arctic.org>
 <3A660746.543226B@cup.hp.com>
 <Pine.LNX.4.30.0101181840380.16292-100000@twinlark.arctic.org>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="=====================_69151694==_.ALT"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=====================_69151694==_.ALT
Content-Type: text/plain; charset="us-ascii"; format=flowed

hi,

At 04:56 PM 20/01/2001 +0200, Kai Henningsen wrote:
>dean-list-linux-kernel@arctic.org (dean gaudet)  wrote on 18.01.01 in 
><Pine.LNX.4.30.0101181840380.16292-100000@twinlark.arctic.org>:
> > i'm pretty sure the actual use of pipelining is pretty disappointing.
> > the work i did in apache preceded the widespread use of HTTP/1.1 and we
>
>What widespread use of HTTP/1.1?

this is probably digressing significantly from linux-kernel related issues, 
but i owuld say that HTTP/1.1 usage is more widespread than your probably 
think.

from the statistics of a beta site running a commercial transparent caching 
software:
         <cache># show statistics http requests
                                       Statistics - Requests
                                        Total       %
                                 ---------------------------
         ...
                    HTTP 0.9 Requests:      41907     0.0
                    HTTP 1.0 Requests:   37563201    24.1
                    HTTP 1.1 Requests:  118282092    75.9
                HTTP Unknown Requests:          1     0.0
         ...


cheers,

lincoln.
--=====================_69151694==_.ALT
Content-Type: text/html; charset="us-ascii"

<html>
hi,<br>
<br>
At 04:56 PM 20/01/2001 +0200, Kai Henningsen wrote:<br>
<blockquote type=cite cite>dean-list-linux-kernel@arctic.org (dean
gaudet)&nbsp; wrote on 18.01.01 in
&lt;Pine.LNX.4.30.0101181840380.16292-100000@twinlark.arctic.org&gt;:<br>
&gt; i'm pretty sure the actual use of pipelining is pretty
disappointing.<br>
&gt; the work i did in apache preceded the widespread use of HTTP/1.1 and
we<br>
<br>
What widespread use of HTTP/1.1?</blockquote><br>
this is probably digressing significantly from linux-kernel related
issues, but i owuld say that HTTP/1.1 usage is more widespread than your
probably think.<br>
<br>
from the statistics of a beta site running a commercial transparent
caching software:<br>
<x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</x-tab>&lt;cache&gt;#
show statistics http requests<br>
<font face="Courier New, Courier"><x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Statistics - Requests<br>
&nbsp;&nbsp;&nbsp;&nbsp;
<x-tab>&nbsp;&nbsp;&nbsp;</x-tab>&nbsp;&nbsp;&nbsp;&nbsp;
<x-tab>&nbsp;&nbsp;&nbsp;</x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; %<br>
&nbsp;&nbsp;&nbsp;&nbsp;
<x-tab>&nbsp;&nbsp;&nbsp;</x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
---------------------------<br>
</font><x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</x-tab>...<br>
<font face="Courier New, Courier"><x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
HTTP 0.9 Requests:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
41907&nbsp;&nbsp;&nbsp;&nbsp; 0.0<br>
<x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
HTTP 1.0 Requests:&nbsp;&nbsp; 37563201&nbsp;&nbsp;&nbsp; 24.1<br>
<x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
HTTP 1.1 Requests:&nbsp; 118282092&nbsp;&nbsp;&nbsp; 75.9<br>
<x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
HTTP Unknown
Requests:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
1&nbsp;&nbsp;&nbsp;&nbsp; 0.0<br>
</font><x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</x-tab>...<br>
<br>
<br>
<font face="Courier New, Courier">cheers,<br>
<br>
lincoln.</font></html>

--=====================_69151694==_.ALT--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
