Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267471AbTGHP0i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 11:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267473AbTGHP0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 11:26:38 -0400
Received: from www4.mail.lycos.com ([209.202.220.170]:2881 "HELO lycos.com")
	by vger.kernel.org with SMTP id S267471AbTGHP0h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 11:26:37 -0400
To: "Kernel" <linux-kernel@vger.kernel.org>,
       "Jan-Benedict Glaw" <jbglaw@lug-owl.de>
Date: Tue, 08 Jul 2003 22:40:53 +0700
From: "Tace  " <tace@lycos.com>
Message-ID: <JGJMIEHJHFNACGAA@mailcity.com>
Mime-Version: 1.0
X-Sent-Mail: off
Reply-To: tace@lycos.com
X-Mailer: MailCity Service
X-Priority: 3
Subject: Re: Linksys gpl code [OT]
X-Sender-Ip: 202.156.2.218
Organization: Lycos Mail  (http://www.mail.lycos.com:80)
Content-Type: text/plain; charset=us-ascii
Content-Language: en
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  does anyone know what kind of assembly code the linksys gpl code compiles to? i.e. ARM?

--------- Original Message ---------

DATE: Tue, 8 Jul 2003 16:45:10 
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Kernel <linux-kernel@vger.kernel.org>
Cc: 

>On Tue, 2003-07-08 12:30:58 +0100, Matthew Hall <matt@ecsc.co.uk>
>wrote in message <1057663858.3959.41.camel@miyazaki>:
>> Hi lkml,
>> 	I don't know if anyone's noticed, but Linksys have opened up and
>> released their code.
>> 
>> http://www.linksys.com/support/gpl.asp
>> 
>> Don't know if it satisfies the gpl; i'm currently downloading the stuff
>> to see what's different from the release sources.
>
>I downloaded that kernel.tgz and diff'ed it out - it's a *hugh* patch
>removing tons of comments and #if 0 ... #endif parts. That makes it
>more complicated to find the "interesting" parts for us, but also it
>will get hard for them to ever port that changes over to 2.4.current...
>
>MfG, JBG
>
>-- 
>   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
>   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
>    fuer einen Freien Staat voll Freier Bürger" | im Internet! |   im Irak!
>      ret = do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));
>



____________________________________________________________
Get advanced SPAM filtering on Webmail or POP Mail ... Get Lycos Mail!
http://login.mail.lycos.com/r/referral?aid=27005
