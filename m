Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264573AbTLGVPA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 16:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264564AbTLGVMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 16:12:25 -0500
Received: from ferreol-1-82-66-171-16.fbx.proxad.net ([82.66.171.16]:6660 "EHLO
	diablo.hd.free.fr") by vger.kernel.org with ESMTP id S264553AbTLGVKK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 16:10:10 -0500
Message-ID: <3FD39722.8000500@free.fr>
Date: Sun, 07 Dec 2003 22:09:54 +0100
From: Vince <fuzzy77@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031105 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Duncan Sands <baldrick@free.fr>
CC: "Randy.Dunlap" <rddunlap@osdl.org>, mfedyk@matchmail.com,
       zwane@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
References: <3FC4E8C8.4070902@free.fr> <200312050838.58349.baldrick@free.fr> <3FD059BD.1090704@free.fr> <200312070125.56251.baldrick@free.fr>
In-Reply-To: <200312070125.56251.baldrick@free.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Duncan Sands wrote:

> 
> Does this help?  It isn't finished - it represents the current state of my fix.
> Warning: have barf bag ready.
 > [patch cut]

Yes, your patch fixes the problem: no more oops and modem_run now exits 
cleanly. Thank you very much !

Vincent

