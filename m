Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbVKUTWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbVKUTWW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 14:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750986AbVKUTWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 14:22:22 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:17792 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S1750778AbVKUTWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 14:22:21 -0500
Message-ID: <43821E5B.3040307@nortel.com>
Date: Mon, 21 Nov 2005 13:22:03 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rob Landley <rob@landley.net>
CC: Xose Vazquez Perez <xose.vazquez@gmail.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Documentation dir is a mess
References: <438069BD.6000401@gmail.com> <200511211028.28944.rob@landley.net> <4381F957.3070007@nortel.com> <200511211205.12861.rob@landley.net>
In-Reply-To: <200511211205.12861.rob@landley.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Nov 2005 19:22:04.0957 (UTC) FILETIME=[DB499CD0:01C5EED0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:

> Except that I picked proc.txt because the contents of the file are really 
> about the whole source tree.  (This isn't documentation about the proc 
> filesystem infrastructure, it's documentation about all known users of that 
> infrastructure...)

This depends on how you're looking at it.

Documentation/filesystems/proc.txt is written from a "user" perspective, 
not a "kernel developer" perspective.

 From the user perspective, this file documents the contents of "/proc" 
which is one single place.

Chris
