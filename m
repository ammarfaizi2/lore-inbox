Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264396AbTKZXlz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 18:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264397AbTKZXlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 18:41:55 -0500
Received: from ferreol-1-82-66-171-16.fbx.proxad.net ([82.66.171.16]:55755
	"EHLO diablo.hd.free.fr") by vger.kernel.org with ESMTP
	id S264396AbTKZXly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 18:41:54 -0500
Message-ID: <3FC53A3B.50601@free.fr>
Date: Thu, 27 Nov 2003 00:41:47 +0100
From: Vince <fuzzy77@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031105 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [kernel panic @ reboot] 2.6.0-test10-mm1
References: <3FC4DA17.4000608@free.fr> <Pine.LNX.4.58.0311261213510.1683@montezuma.fsmlabs.com> <3FC4E42A.40906@free.fr> <Pine.LNX.4.58.0311261240210.1683@montezuma.fsmlabs.com> <3FC4E8C8.4070902@free.fr> <Pine.LNX.4.58.0311261305020.1683@montezuma.fsmlabs.com> <20031126233738.GD1566@mis-mike-wstn.matchmail.com>
In-Reply-To: <20031126233738.GD1566@mis-mike-wstn.matchmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:
> Interesting.  It would be nice to have a boot option that halts the system
> after the first oops, instead of trying to continue.
> 
> Vince/Randy:
> Did you use the 2.5.65 patch at http://w.ods.org/tools/kmsgdump/ or is there
> some other place that has newer patches?
> 
> BTW, http://www.xenotime.net/linux/kmsgdump gives a 404 error.

My version comes from:
http://developer.osdl.org/rddunlap/kmsgdump/

