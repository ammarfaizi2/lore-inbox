Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751028AbVKUQoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbVKUQoP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 11:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbVKUQoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 11:44:15 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:10658 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id S1751028AbVKUQoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 11:44:13 -0500
Message-ID: <4381F957.3070007@nortel.com>
Date: Mon, 21 Nov 2005 10:44:07 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rob Landley <rob@landley.net>
CC: Xose Vazquez Perez <xose.vazquez@gmail.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Documentation dir is a mess
References: <438069BD.6000401@gmail.com> <200511211028.28944.rob@landley.net>
In-Reply-To: <200511211028.28944.rob@landley.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Nov 2005 16:44:09.0209 (UTC) FILETIME=[CB4D3690:01C5EEBA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:
> On Sunday 20 November 2005 06:19, Xose Vazquez Perez wrote:

>>_today_ Documentation/* is a mess of files. It would be good
>>to have the _same_ tree as the code has:

> Where would you put Documentation/unicode.txt in your proposed layout?  Or

One logical place would be to leave stuff that applies to the whole tree 
at the top level.  Thus, it would just stay "Documentation/unicode.txt".

> Documentation/filesystems/proc.txt?

This one seems obvious:

Documentation/fs/proc.txt

Chris
