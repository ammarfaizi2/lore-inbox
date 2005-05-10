Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261740AbVEJSwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261740AbVEJSwj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 14:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbVEJSwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 14:52:39 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:9606 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id S261740AbVEJSwd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 14:52:33 -0400
Message-ID: <428102E8.2020509@namesys.com>
Date: Tue, 10 May 2005 11:52:24 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: sean.mcgrath@propylon.com
CC: Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: file as a directory
References: <2c59f00304112205546349e88e@mail.gmail.com>	 <41A1FFFC.70507@hist.no> <41A21EAA.2090603@dbservice.com>	 <41A23496.505@namesys.com>  <1101287762.1267.41.camel@pear.st-and.ac.uk>	 <1115717961.3711.56.camel@grape.st-and.ac.uk>	 <4280CAEF.5060202@namesys.com> <1115739129.3711.117.camel@grape.st-and.ac.uk> <4280E1A9.3010703@propylon.com> <4280EEA7.9080403@namesys.com> <4280F1D5.3060607@propylon.com>
In-Reply-To: <4280F1D5.3060607@propylon.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean McGrath wrote:

> Hans Reiser wrote:
>
>> Sean McGrath wrote:
>>
>>  
>>
>>> The thing that interests me most is the difference (if any) between
>>> giving a stream of bytes an opaque name e.g. "Chapter 1 of my
>>> book.sxw" versus giving a stream of bytes a query expression that can
>>> also be considered an opaque name e.g.
>>> "/book/chapter[1] "
>>>
>>>   
>>
>> What is an opaque name?
>>
>>
>>  
>>
> By "opaque name" I mean a name that is purely a label. A name that
> cannot be interpreted as a query expression.

Isn't query just another name for name?

>
> Sean
>
>
>
>
>

