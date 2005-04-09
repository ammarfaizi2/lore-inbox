Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261416AbVDIXeC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbVDIXeC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 19:34:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261417AbVDIXeC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 19:34:02 -0400
Received: from adsl-69-233-54-142.dsl.pltn13.pacbell.net ([69.233.54.142]:41736
	"EHLO bastard.smallmerchant.com") by vger.kernel.org with ESMTP
	id S261416AbVDIXb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 19:31:57 -0400
Message-ID: <425865BC.6090006@tupshin.com>
Date: Sat, 09 Apr 2005 16:31:08 -0700
From: Tupshin Harper <tupshin@tupshin.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Roman Zippel <zippel@linux-m68k.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>, Martin Pool <mbp@sourcefrog.net>,
       David Lang <dlang@digitalinsight.com>
Subject: Re: Kernel SCM saga..
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org> <20050406193911.GA11659@stingr.stingr.net> <pan.2005.04.07.01.40.20.998237@sourcefrog.net> <20050407014727.GA17970@havoc.gtf.org> <pan.2005.04.07.02.25.56.501269@sourcefrog.net> <Pine.LNX.4.62.0504061931560.10158@qynat.qvtvafvgr.pbz> <1112852302.29544.75.camel@hope> <Pine.LNX.4.58.0504071626290.28951@ppc970.osdl.org> <1112939769.29544.161.camel@hope> <Pine.LNX.4.58.0504072334310.28951@ppc970.osdl.org> <20050408083839.GC3957@opteron.random> <Pine.LNX.4.58.0504081647510.28951@ppc970.osdl.org> <Pine.LNX.4.61.0504091547320.15339@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0504091547320.15339@scrub.home>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:

>It seems you exported the complete parent information and this is exactly 
>the "nitty-gritty" I was "whining" about and which is not available via 
>bkcvs or bkweb and it's the most crucial information to make the bk data 
>useful outside of bk. Larry was previously very clear about this that he 
>considers this proprietary bk meta data and anyone attempting to export 
>this information is in violation with the free bk licence, so you indeed 
>just took the important parts and this is/was explicitly verboten for 
>normal bk users.
>  
>
Yes, this is exactly the information that would be necessary to create a 
general interop tool between bk and darcs|arch|monotone, and is the 
fundamental objection I and others have had to open source projects 
using BK. Is Bitmover willing to grant a special dispensation to allow a 
lossless conversion of the linux history to another format?

-Tupshin
