Return-Path: <linux-kernel-owner+w=401wt.eu-S1754788AbXABCT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754788AbXABCT0 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 21:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754803AbXABCT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 21:19:26 -0500
Received: from terminus.zytor.com ([192.83.249.54]:52989 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754788AbXABCTZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 21:19:25 -0500
Message-ID: <4599C125.10409@zytor.com>
Date: Mon, 01 Jan 2007 18:19:17 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: gorcunov@gmail.com
CC: Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Happy New Year (and v2.6.20-rc3 released)
References: <Pine.LNX.4.64.0612311710430.4473@woody.osdl.org> <200701011022.54336.gorcunov@gmail.com>
In-Reply-To: <200701011022.54336.gorcunov@gmail.com>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cyrill V. Gorcnov wrote:
> On Monday 01 January 2007 04:19, you wrote:
> |  
> |  In order to not get in trouble with MADR ("Mothers Against Drunk 
> |  Releases") I decided to cut the 2.6.20-rc3 release early rather than wait 
> |  for midnight, because it's bound to be new years _somewhere_ out there. So 
> |  here's to a happy 2007 for everybody.
> |  
> 
> I've tried to clone linux git repo and got:
> 
> 	git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> 	fatal: unexpected EOF
> 	fetch-pack from 'git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git' failed.
> 
> What's wrong?
> 
> Happy New Year ;)
> 

Look at http://www.kernel.org/.  Currently, the git daemon stops serving 
new clients at loadavg 200.

	-hpa
