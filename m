Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264112AbUDREJl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 00:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264114AbUDREJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 00:09:41 -0400
Received: from ns1.skjellin.no ([80.239.42.66]:51642 "HELO mail.skjellin.no")
	by vger.kernel.org with SMTP id S264112AbUDREJl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 00:09:41 -0400
Message-ID: <4081FF84.4030907@tomt.net>
Date: Sun, 18 Apr 2004 06:09:40 +0200
From: Andre Tomt <andre@tomt.net>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: NFS exporting imports?
References: <200404180317.i3I3HD3x013445@work.bitmover.com>
In-Reply-To: <200404180317.i3I3HD3x013445@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:
<snip>
> And while I'm here, is anyone maintaining the user level NFS server?  Or
> has anyone made it work on a recent kernel?  

When I was in sudden need for NFS on a server with a nonstandard kernel 
installation and didn't have time to recompile, it worked just fine. 
This was with kernel 2.4.24 or 2.4.25, on Debian Sarge (package 
"nfs-user-server"). Upstream maintainers looks pretty dead, but Debian 
has a at least kept it in a working state in their archive.
