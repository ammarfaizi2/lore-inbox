Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265661AbTIJU2Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 16:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265664AbTIJU2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 16:28:24 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:19975 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S265661AbTIJU2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 16:28:23 -0400
Message-ID: <3F5F8E90.4020701@techsource.com>
Date: Wed, 10 Sep 2003 16:50:24 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: James Clark <jimwclark@ntlworld.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Driver Model 2 Proposal - Linux Kernel Performance v Usability
References: <1062637356.846.3471.camel@cube> <200309042114.45234.jimwclark@ntlworld.com> <Pine.LNX.4.53.0309041723090.9557@chaos>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just have one quick question about all of this:

People mention that driver interfaces don't change much in stable 
releases, but if memory serves, symbol versioning information changes 
with each minor release, requiring a recompile of modules.

Would it be possible to have a driver module which can be dropped into, 
say, 2.6.17 that can also be dropped into 2.6.18 as long as the 
interface doesn't change?

