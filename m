Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129741AbRBLUM5>; Mon, 12 Feb 2001 15:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129231AbRBLUMi>; Mon, 12 Feb 2001 15:12:38 -0500
Received: from betty.magenta-netlogic.com ([193.37.229.181]:14084 "EHLO
	betty.magenta-netlogic.com") by vger.kernel.org with ESMTP
	id <S129741AbRBLUM0>; Mon, 12 Feb 2001 15:12:26 -0500
Message-ID: <3A884456.4080103@magenta-netlogic.com>
Date: Mon, 12 Feb 2001 20:15:18 +0000
From: Tony Hoyle <tmh@magenta-netlogic.com>
Organization: Magenta Logic
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; 0.7) Gecko/20010109
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Tweedy <pault@5emedia.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: "Unable to load intepreter" on login - 2.2.14-5.0
In-Reply-To: <B6ADBFF3.3E19%pault@5emedia.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Tweedy wrote:

> Secondly, to get the thing running I'm assuming I can copy a working login
> binary from an identical server, so I can get in & change the passwords and
> sort the security out?

...and what if the 'cp' binary has been hacked to stop you doing just 
that?  What if 'passwd' is silently emailing your root password to the 
hacker each time you change it?

Reformat and re-install.  It's the only way (and check your firewall).

Tony
-- 

The only secure computer is one that's unplugged, locked in a safe,
and buried 20 feet under the ground in a secret location... and i'm
not even too sure about that one"--Dennis Huges, FBI.

tmh@magenta-netlogic.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
