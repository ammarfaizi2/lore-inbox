Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261907AbUDXEOm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbUDXEOm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 00:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbUDXEOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 00:14:42 -0400
Received: from opersys.com ([64.40.108.71]:25611 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261907AbUDXEOl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 00:14:41 -0400
Message-ID: <4089E8B4.5060102@opersys.com>
Date: Sat, 24 Apr 2004 00:10:28 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Dariusz Tylus <dtdarek@o2.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: Rtlinux - kernel panic on rtlinux init
References: <408939AC.6050804@o2.pl>
In-Reply-To: <408939AC.6050804@o2.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dariusz Tylus wrote:
> I have already instaled rtLinyx 3.2 pre3 with kernel 2.4.22
> When I type "rtlinux start" the system crash,
> there is kernel panic
> On the screen is dump of registers and some lines like this:
> 
> Attempt to kill the idle task
> In idle task - not syncing.
> ...
> Unable to handle kernel paging request at virtual adres 80731744
> 
> I would like some advice what should I do,

You should be using RTAI:
http://www.aero.polimi.it/~rtai/

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546

