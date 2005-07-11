Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262267AbVGKGhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262267AbVGKGhF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 02:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262265AbVGKGhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 02:37:05 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:14036 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S262263AbVGKGhC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 02:37:02 -0400
References: <OFB01287B5.D35EDB80-ON88257038.005DEE97-88257038.005EDB8B@us.ibm.com>
            <courier.42CEC422.00001C6C@courier.cs.helsinki.fi>
            <Pine.LNX.4.61.0507082108530.3728@scrub.home>
            <1120851221.9655.17.camel@localhost>
            <Pine.LNX.4.61.0507082154090.3728@scrub.home>
            <1121019702.20821.17.camel@localhost>
            <Pine.LNX.4.61.0507102047380.3728@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0507102047380.3728@scrub.home>
From: "Pekka J Enberg" <penberg@cs.helsinki.fi>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Bryan Henderson <hbryan@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       bfields@fieldses.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, linuxram@us.ibm.com, mike@waychison.com,
       Miklos Szeredi <miklos@szeredi.hu>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: share/private/slave a subtree - define vs enum
Date: Mon, 11 Jul 2005 09:37:01 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8,iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <courier.42D2138D.00004B15@courier.cs.helsinki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman, 

Roman Zippel writes:
> I don't generally disagree with that, I just think that defines are not 
> part of that list.

They're in Documentation/CodingStyle (see Chapter 11). 

Roman Zippel writes:
> Look, it's great that you do reviews, but please keep in mind it's the 
> author who has to work with code and he has to be primarily happy with, 
> so you don't have to point out every minor issue.

I completely agree with you that the author must be happy with the code. I 
also think Vojtech has a good point about reviewing for the most important 
things first and worrying about nitpicks later. 

I'll try to find a better balance for reviews. Thanks Roman. 

                  Pekka 

