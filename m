Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262251AbTJ3IKL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 03:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262253AbTJ3IKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 03:10:11 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:2976 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id S262251AbTJ3IKH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 03:10:07 -0500
Message-ID: <3FA0C75E.9000601@namesys.com>
Date: Thu, 30 Oct 2003 11:10:06 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christian Axelsson <smiler@lanil.mine.nu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Things that Longhorn seems to be doing right
References: <3F9F7F66.9060008@namesys.com> <3FA0BCDE.7080201@lanil.mine.nu>
In-Reply-To: <3FA0BCDE.7080201@lanil.mine.nu>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Axelsson wrote:

> Hans Reiser wrote:
>
>> They are building in support for transactions into the OS.
>>
>> Everything will be in XML.  (It is not so important what format it is 
>> in, as it is that they are going to do it in one format.)
>>
>> Support for browsing versions in the FS.
>>
>> Support for browsing and querying XML their unified format.  Ok, so 
>> SQL sucks, but this is still better than what we offer today in Linux.
>
>
> I think this is better implemented in userspace somehow to keep the 
> kernel away from bloat.
> What do you think of the GNOME Storage project: 
> http://www.gnome.org/~seth/storage/
>
> Its not exactly the same but maybe its going in that direction.
>
well, I much much prefer www.namesys.com/whitepaper.html ;-)

The reasons why SQL sucks for semi-structured data are described there.

-- 
Hans


