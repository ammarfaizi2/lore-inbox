Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262784AbTLDBCG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 20:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262788AbTLDBCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 20:02:06 -0500
Received: from ferreol-1-82-66-171-16.fbx.proxad.net ([82.66.171.16]:49420
	"EHLO diablo.hd.free.fr") by vger.kernel.org with ESMTP
	id S262784AbTLDBCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 20:02:03 -0500
Message-ID: <3FCE877B.3010703@free.fr>
Date: Thu, 04 Dec 2003 02:01:47 +0100
From: Vince <fuzzy77@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031105 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@holomorphy.com>
CC: "Randy.Dunlap" <rddunlap@osdl.org>, Mike Fedyk <mfedyk@matchmail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [kernel panic @ reboot] 2.6.0-test10-mm1
References: <3FC4DA17.4000608@free.fr> <Pine.LNX.4.58.0311261213510.1683@montezuma.fsmlabs.com> <3FC4E42A.40906@free.fr> <Pine.LNX.4.58.0311261240210.1683@montezuma.fsmlabs.com> <3FC4E8C8.4070902@free.fr> <Pine.LNX.4.58.0311261305020.1683@montezuma.fsmlabs.com> <20031126233738.GD1566@mis-mike-wstn.matchmail.com> <3FC53A3B.50601@free.fr> <20031202160303.2af39da0.rddunlap@osdl.org> <20031203003106.GF4154@mis-mike-wstn.matchmail.com> <20031202162745.40c99509.rddunlap@osdl.org> <3FCDE506.7020302@free.fr> <Pine.LNX.4.58.0312031409410.27578@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.58.0312031409410.27578@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> On Wed, 3 Dec 2003, Vince wrote:
> 
> 
>>Well, I get indeed a nice oops on screen with this sysctl... but the
>>oops/panic does not appear on the floppy dump  :-/
>>
>>--------------------------------------------------------
>><0>Kernel panic: Fatal exception
>><4> <0>Dumping messages in 100 seconds : last chance for
>>Alt-SysRq...<6>SysRq :
>>Emergency Sync
>><6>SysRq : Emergency Sync
>><6>SysRq : Emergency Remount R/O
>><6>SysRq : Trying to dump through real mode
>><4>
>>---------------------------------------------------------
> 
> 
> Do you see any floppy disk activity at all? I'll see if i can come up with
> something.

Yes, there *is* floppy activity. The previous messages make it to the 
floppy (in that case, I experienced with 
Alt-Sysrq+S/Alt-Sysrq+U/Alt-Sysrq+D), but the oops doesn't...

