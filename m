Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261852AbULKFQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbULKFQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 00:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbULKFQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 00:16:57 -0500
Received: from anchor-post-36.mail.demon.net ([194.217.242.86]:55051 "EHLO
	anchor-post-36.mail.demon.net") by vger.kernel.org with ESMTP
	id S261832AbULKFQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 00:16:52 -0500
Message-ID: <41BA825F.9040509@lougher.demon.co.uk>
Date: Sat, 11 Dec 2004 05:15:11 +0000
From: Phillip Lougher <phillip@lougher.demon.co.uk>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041012)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org,
       "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [Announce] Squashfs 2.1 released (compressed filesystem)
References: <41BA0245.4050502@lougher.demon.co.uk> <20041211013323.GA12796@kroah.com>
In-Reply-To: <20041211013323.GA12796@kroah.com>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Fri, Dec 10, 2004 at 08:08:37PM +0000, Phillip Lougher wrote:
> 
>>I'm pleased to announce the release of Squashfs 2.1.
> 
> 
> Are you going to submit this fs for inclusion in the main kernel tree?
> I'm getting tired of maintaining it as part of the Gentoo kernel patch
> set :)

Good question...  When I originally released Squashfs (Oct 2002) the 2.5 
kernel had just gone into the feature freeze and I was waiting for the 
unfreeze that would happen when 2.7 arrived.  As the official stance on 
additions to 2.6 has been relaxed I have thought about submitting it.

I need to tidy up the code a bit before I submit it to the merciless 
scrutiny of LKML :-)  Nothing bad (I hope) but there's lots of long 
lines and I do know LKML'mers like 80 columns.

I'm planning on adding ea/acl support (people have been asking for 
them), I can't decide whether to submit it now or wait until I've 
finished them.  Suggestions and advice would be welcome.

Slightly off topic, I've noticed you're the kernel maintainer for 
Gentoo.  You mentioned somewhere you're down to 4 kernel patches, 
including Squashfs? :) A lot of people/projects are now using Squashfs 
and it would help a lot of people (and me) if it did get into the 
kernel.  Plus it would be a nice thing for me anyway to have finally got 
it included.

Regards

Phillip

