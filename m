Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262388AbVDLM2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262388AbVDLM2Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 08:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbVDLM1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 08:27:44 -0400
Received: from rrcs-24-123-59-149.central.biz.rr.com ([24.123.59.149]:62960
	"EHLO galon.ev-en.org") by vger.kernel.org with ESMTP
	id S262388AbVDLMYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 08:24:36 -0400
Message-ID: <425BBDF9.9020903@ev-en.org>
Date: Tue, 12 Apr 2005 13:24:25 +0100
From: Baruch Even <baruch@ev-en.org>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John M Collins <jmc@xisl.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Exploit in 2.6 kernels
References: <1113298455.16274.72.camel@caveman.xisl.com>
In-Reply-To: <1113298455.16274.72.camel@caveman.xisl.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can find the source at 
http://www.securiteam.com/exploits/5VP0N0UF5U.html

The fix: 
http://linux.bkbits.net:8080/linux-2.6/cset@422dd06a1p5PsyFhoGAJseinjEq3ew?nav=index.html|ChangeSet@-1d

CAN: http://www.cve.mitre.org/cgi-bin/cvename.cgi?name=CAN-2005-0736

John M Collins wrote:
> Please CC any reply to jmc AT xisl.com as I'm not subscribed - thanks
> 
> We had 5 machines broken into last night all but one with kernel 2.6.8
> and found a binary "krad-no-longer-private.c" had  been downloaded
> 
> It contains the string:
>  
> k-rad.c - linux 2.6.* CPL 0 kernel exploit 
> Discovered Jan 2005 by sd <sd@fucksheep.org>
> 
> If you want to look at it, I've copied it (with mode set to 444 of
> course) to www.xisl.com/hack
> 
> Hope that is helpful
> 

