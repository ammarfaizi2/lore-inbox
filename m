Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268511AbUHYHhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268511AbUHYHhK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 03:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268515AbUHYHhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 03:37:10 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:40718 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S268511AbUHYHhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 03:37:04 -0400
Message-ID: <412C4295.1000700@hist.no>
Date: Wed, 25 Aug 2004 09:41:09 +0200
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David N. Welton" <davidw@dedasys.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux Incompatibility List
References: <87r7q0th2n.fsf@dedasys.com>
In-Reply-To: <87r7q0th2n.fsf@dedasys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David N. Welton wrote:

>Hi,
>
>I'm reviving an idea I implemented several years ago, namely the Linux
>Incompatibility List.
>
>The idea is simple: most hardware works fine with Linux, and the
>situation is generally pretty good, with Linux increasingly showing up
>on the corporate radar.
>
>However, there are devices that don't work with Linux, for various
>reasons (no specs, too new and no one has written a driver, etc...),
>and it's easier to keep track of those devices so that people can
>avoid them (or the hero types can write drivers for them).
>
[...]

>I think (correct me if I'm wrong) the information we would want to
>collect is:
>
>Product Name:
>
>Manufacturer:
>
>Model Number:
>
>Chipset:
>
>How bad it is (1 to 10, 9 being it almost works and has only minor
>bugs):
>
>Reason (no specs, driver still being worked on, ...):
>
>Url for more info:
>
>An email address of yours that we may publish (so that we can contact
>you if someone says "no, that works just fine!"):
>
>Notes:
>
>Ideas/comments/suggestions are welcome at this stage.
>
>  
>
An idea:  To really put some pressure on vendors, also have an entry for
"alternate/better solution" where people can list a way to achieve the
same result with someone else's product and open drivers.  Example:

Product: Matrox parhelia  (a triplehead graphichs card)
Reason: Bad binary-only 2D-only driver
Alternate solution: Achieve triplehead with two radeon cards (1 AGP 
dualhead + 1 PCI) instead!

This will be useful for anyone planning a upgrade but finding their 
favourite
solution on the incompatibility list.  And it'll sure put some pressure 
on the manufacturer
to at least get a _good_ driver out (changing the reason), or even 
better, an open one
which get rid of the incompatibility entry. 

Helge Hafting
