Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbTKDUNY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 15:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbTKDUNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 15:13:24 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:49325 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261802AbTKDUNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 15:13:22 -0500
Message-ID: <3FA75F97.3080508@namesys.com>
Date: Tue, 04 Nov 2003 00:13:11 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Timothy Miller <miller@techsource.com>
CC: Nikita Danilov <Nikita@Namesys.COM>, "Theodore Ts'o" <tytso@mit.edu>,
       Erik Andersen <andersen@codepoet.org>, linux-kernel@vger.kernel.org
Subject: Re: Things that Longhorn seems to be doing right
References: <3F9F7F66.9060008@namesys.com>	<20031029224230.GA32463@codepoet.org>	<20031030015212.GD8689@thunk.org>	<3FA0C631.6030905@namesys.com>	<20031030174809.GA10209@thunk.org>	<3FA16545.6070704@namesys.com>	<20031030203146.GA10653@thunk.org>	<3FA211D3.2020008@namesys.com>	<20031031193016.GA1546@thunk.org> <16294.19747.640052.782753@laputa.namesys.com> <3FA6891A.3050400@techsource.com>
In-Reply-To: <3FA6891A.3050400@techsource.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller wrote:

>
>
> Nikita Danilov wrote:
>
>> It is called "a directory". :) There is no crime in putting
>>
>> cc src/*.c
>>
>> into Makefile. I think that Hans' query-result-object denoting multiple
>> objects is more like directory than single regular file.
>
>
> So a file system query that results in multiple files generates a 
> "virtual directory"?
>
>
>
Remember that this code does not exist yet.....;-)

Sounds like it might be a good way to do it though.

-- 
Hans


