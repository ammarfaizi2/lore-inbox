Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270310AbTGMRMu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 13:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270311AbTGMRMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 13:12:50 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:12714 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id S270310AbTGMRMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 13:12:43 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Oliver Martin <oliver.martin@i-one.at>, linux-kernel@vger.kernel.org
Subject: Re: HTree, Orlov for ext3 with 2.4.21
Date: Sun, 13 Jul 2003 19:28:55 +0200
User-Agent: KMail/1.5.2
References: <3F0E6072.7060105@i-one.at>
In-Reply-To: <3F0E6072.7060105@i-one.at>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200307131704.28851.phillips@arcor.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 July 2003 09:00, Oliver Martin wrote:
> Hello,
> I want to use kernel 2.4.21 with the HTree and Orlov patches applied
> with an ext3 filesystem. Where can I get the newest versions thereof
> (for my desired kernel)? I've found
> http://thunk.org/tytso/linux/extfs-2.4-update/ and there is a 2.4.21
> version and I found both the strings Orlov and HTree in it, but I don't
> know if it's really the patch I want, if it's for ext3 and if it's the
> newest version. I've also read of a HTree NFS patch, where can I get it?

It doesn't make a whole lot of sense to do the 2.4 backport before 2.6 opens.
There hasn't been much drift in that corner of the kernel, so it won't be a 
lot of work when the time comes.

Regards,

Daniel

