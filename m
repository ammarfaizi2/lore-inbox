Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285382AbRLNOif>; Fri, 14 Dec 2001 09:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285384AbRLNOiP>; Fri, 14 Dec 2001 09:38:15 -0500
Received: from natwar.webmailer.de ([192.67.198.70]:18836 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S285382AbRLNOiI>; Fri, 14 Dec 2001 09:38:08 -0500
Message-ID: <3C1A0DF6.5030401@korseby.net>
Date: Fri, 14 Dec 2001 15:34:30 +0100
From: Kristian Peters <kristian.peters@korseby.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011209
X-Accept-Language: de, en
MIME-Version: 1.0
To: Wakko Warner <wakko@animx.eu.org>
CC: Kristian Peters <kristian.peters@korseby.net>,
        Jeff <piercejhsd009@earthlink.net>,
        kernel <linux-kernel@vger.kernel.org>
Subject: Re: cdrecord reports size vs. capabilities error....
In-Reply-To: <3C1880F4.8CE5AC8F@earthlink.net> <3C19DEAF.4080703@korseby.net> <20011214064202.A24719@animx.eu.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wakko Warner wrote:

> I get this same thing with a scsi cdrom at work.  I have 2 of the exact same
> drives.  a Teac cd-535s v1.0a  the first one I get that message, the second
> works.  However, the first one won't pull the tray back in via software.


Is the first drive connected to /dev/hdb ? Does eject work on /dev/scd0 or 
/dev/hdb ?

*Kristian

