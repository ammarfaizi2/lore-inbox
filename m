Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbTFFOfk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 10:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbTFFOfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 10:35:39 -0400
Received: from main.gmane.org ([80.91.224.249]:8089 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261797AbTFFOfj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 10:35:39 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Nicholas Wourms <nwourms@myrealbox.com>
Subject: Re: [Patch] 2.5.70-bk9 kick FAR out of the zlib
Date: Fri, 06 Jun 2003 10:49:09 -0400
Message-ID: <3EE0A9E5.9080000@myrealbox.com>
References: <20030605194644.GA22439@wohnheim.fh-wedel.de> <Pine.LNX.4.53.0306051607260.2391@chaos> <20030605203108.GD22439@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@main.gmane.org
Cc: Steven Cole <elenstev@mesatop.com>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel wrote:
> My words were "all or nothing".  Linus was against nothing, so the
> answer is all, that simple.
> 
> As to your "someone comes up with a better zlib" concern, this has
> happened already.  An guess what, we ignored it.  So unless you come
> up with a patch to get the 1.1.4 changes into the kernel and describe
> what the two magic bits are all about, I couldn't care less.

1.1.4 would be a waste of time at this point.  Better to wait for the 
upcoming 1.2.x release, which promises improved performance (esp. on 
x86) and better compression...

Cheers,
Nicholas


