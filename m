Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262529AbVBXXMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262529AbVBXXMY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 18:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262556AbVBXXMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 18:12:24 -0500
Received: from smtp2.netcabo.pt ([212.113.174.29]:49752 "EHLO
	exch01smtp09.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S262529AbVBXXKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 18:10:12 -0500
Message-ID: <38468.192.168.1.5.1109286369.squirrel@192.168.1.5>
In-Reply-To: <16103.195.245.190.94.1109251064.squirrel@195.245.190.94>
References: <40114.195.245.190.93.1109155418.squirrel@195.245.190.93>   
    <421C8CB4.5060605@tiscali.de>
    <16103.195.245.190.94.1109251064.squirrel@195.245.190.94>
Date: Thu, 24 Feb 2005 23:06:09 -0000 (WET)
Subject: Re: 2.6.11-rc4-RT-V0.7.39-02 kernel BUG
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Rui Nuno Capela" <rncbc@rncbc.org>
Cc: "Matthias-Christian Ott" <matthias.christian@tiscali.de>,
       "Ingo Molnar" <mingo@elte.hu>, "LKML" <linux-kernel@vger.kernel.org>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 24 Feb 2005 23:10:11.0487 (UTC) FILETIME=[FD8FDAF0:01C51AC5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Matthias-Christian wrote:
>>
>> Hi!
>> The first bug is in the usbb ohci module (report it to
>> http://buzilla.kernel.org and its Maintainers). The second one is
>> caused by the first one.
>>
>
> Done.
>
> Bugzilla bug #4247:
>   http://bugzilla.kernel.org/show_bug.cgi?id=4247
>

And this was the response:

greg@kroah.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |REJECTED
         Resolution|                            |INVALID

------- Additional Comments From greg@kroah.com  2005-02-24 11:11 -------
As you are using Ingo's patches, please post this to him, in an email, not
on here.


Now what?
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

