Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277692AbRJLNkz>; Fri, 12 Oct 2001 09:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277686AbRJLNkq>; Fri, 12 Oct 2001 09:40:46 -0400
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:7094 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S277693AbRJLNkf>; Fri, 12 Oct 2001 09:40:35 -0400
Message-ID: <3BC6F32B.E78D372E@nortelnetworks.com>
Date: Fri, 12 Oct 2001 09:42:03 -0400
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: so, no way to kill process? have to reboot?
In-Reply-To: <3BC6097F.79B6E2D1@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@nortelnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Friesen, Christopher [CAR:3R60:EXCH]" wrote:

Well, I've rebooted the thing.

It appears that whatever it was looping on was in the kernel.  I suspect that it
has something to do with NFS--this is a 2.2.17 kernel and we ran into some
issues with it and NFS on some other systems.

Thanks for the help guys...unfortunately I rebooted before getting the messages
about checking in /proc--it would have been interesting to see what it was
doing.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
