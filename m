Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261719AbVEJRju@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbVEJRju (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 13:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbVEJRja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 13:39:30 -0400
Received: from mail07.svc.cra.dublin.eircom.net ([159.134.118.23]:31597 "HELO
	mail07.svc.cra.dublin.eircom.net") by vger.kernel.org with SMTP
	id S261713AbVEJRj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 13:39:26 -0400
Message-ID: <4280F1D5.3060607@propylon.com>
Date: Tue, 10 May 2005 18:39:33 +0100
From: Sean McGrath <sean.mcgrath@propylon.com>
Reply-To: sean.mcgrath@propylon.com
Organization: Propylon
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: file as a directory
References: <2c59f00304112205546349e88e@mail.gmail.com>	 <41A1FFFC.70507@hist.no> <41A21EAA.2090603@dbservice.com>	 <41A23496.505@namesys.com>  <1101287762.1267.41.camel@pear.st-and.ac.uk>	 <1115717961.3711.56.camel@grape.st-and.ac.uk>	 <4280CAEF.5060202@namesys.com> <1115739129.3711.117.camel@grape.st-and.ac.uk> <4280E1A9.3010703@propylon.com> <4280EEA7.9080403@namesys.com>
In-Reply-To: <4280EEA7.9080403@namesys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:

>Sean McGrath wrote:
>
>  
>
>>The thing that interests me most is the difference (if any) between
>>giving a stream of bytes an opaque name e.g. "Chapter 1 of my
>>book.sxw" versus giving a stream of bytes a query expression that can
>>also be considered an opaque name e.g.
>>"/book/chapter[1] "
>>
>>    
>>
>What is an opaque name?
>
>
>  
>
By "opaque name" I mean a name that is purely a label. A name that 
cannot be interpreted as a query expression.

Sean



