Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbTKCQvU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 11:51:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbTKCQvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 11:51:20 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:41739 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S262110AbTKCQvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 11:51:17 -0500
Message-ID: <3FA6891A.3050400@techsource.com>
Date: Mon, 03 Nov 2003 11:58:02 -0500
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nikita Danilov <Nikita@Namesys.COM>
CC: "Theodore Ts'o" <tytso@mit.edu>, Hans Reiser <reiser@namesys.com>,
       Erik Andersen <andersen@codepoet.org>, linux-kernel@vger.kernel.org
Subject: Re: Things that Longhorn seems to be doing right
References: <3F9F7F66.9060008@namesys.com>	<20031029224230.GA32463@codepoet.org>	<20031030015212.GD8689@thunk.org>	<3FA0C631.6030905@namesys.com>	<20031030174809.GA10209@thunk.org>	<3FA16545.6070704@namesys.com>	<20031030203146.GA10653@thunk.org>	<3FA211D3.2020008@namesys.com>	<20031031193016.GA1546@thunk.org> <16294.19747.640052.782753@laputa.namesys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nikita Danilov wrote:

> It is called "a directory". :) There is no crime in putting
> 
> cc src/*.c
> 
> into Makefile. I think that Hans' query-result-object denoting multiple
> objects is more like directory than single regular file.

So a file system query that results in multiple files generates a 
"virtual directory"?

