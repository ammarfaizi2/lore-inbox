Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265549AbUA0Q25 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 11:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265578AbUA0Q25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 11:28:57 -0500
Received: from gw-nl6.philips.com ([161.85.127.52]:51188 "EHLO
	gw-nl6.philips.com") by vger.kernel.org with ESMTP id S265549AbUA0Q2A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 11:28:00 -0500
Message-ID: <40169236.2050606@basmevissen.nl>
Date: Tue, 27 Jan 2004 17:30:46 +0100
From: Bas Mevissen <ml@basmevissen.nl>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
Cc: rmps@joel.ist.utl.pt, linux-kernel@vger.kernel.org,
       yoshfuji@linux-ipv6.org
Subject: Re: RFC: Trailing blanks in source files
References: <Pine.LNX.4.58.0401271544120.27260@joel.ist.utl.pt> <20040128.011537.81631272.yoshfuji@linux-ipv6.org>
In-Reply-To: <20040128.011537.81631272.yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

YOSHIFUJI Hideaki / ???? wrote:
> In article <Pine.LNX.4.58.0401271544120.27260@joel.ist.utl.pt> (at Tue, 27 Jan 2004 15:44:56 +0000 (WET)), Rui Saraiva <rmps@joel.ist.utl.pt> says:
> 
> 
>>	It seems that many files [1] in the Linux source have lines with
>>trailing blank (space and tab) characters and some even have formfeed
>>characters. Obviously these blank characters aren't necessary.
> 
> 
> I do not like to change this if it is done blindly.
> 

Agree. But if you compile a allconfigyes kernel before and after and 
they appear to be binary equal, we know we are pretty safe :-)


Regards,

Bas.

