Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261742AbREVOPc>; Tue, 22 May 2001 10:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261744AbREVOPX>; Tue, 22 May 2001 10:15:23 -0400
Received: from [192.48.153.1] ([192.48.153.1]:60238 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S261726AbREVOPK>;
	Tue, 22 May 2001 10:15:10 -0400
Message-ID: <3B0A7523.8641A688@sgi.com>
Date: Tue, 22 May 2001 09:18:11 -0500
From: Steve Modica <modica@sgi.com>
Reply-To: modica@sgi.com
Organization: sgi
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.19-4.1mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-hams@vger.kernel.org, linux-ppp@vger.kernel.org
Subject: Re: ECN is on!
In-Reply-To: <20010522131031.C5947@mea-ext.zmailer.org> <15114.18990.597124.656559@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
> Matti Aarnio writes:
>  > I am contemplating to periodically turn off the ECN bit to
>  > let email out, but DaveM has veto there.
> 
> I veto, the whole point of moving to ECN was to make a statement and
> get people to fix their kit.
> 
> We will remove these people, that's all.
> 
> Later,
> David S. Miller
> davem@redhat.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-net" in
> the body of a message to majordomo@vger.kernel.org

Perhaps it's none of my business, but it doesn't seem very sporting to
just turn something on that breaks stuff and say "you had fair
warning".  Why not shut it back off, issue a statement saying it works
now and will be re-enabled on June 10th or something, and everyone must
do thus and so or they will break on that day?

Vague things like "it'll be turned on real soon now" or ASAP really mean
"never" since admins always have things with real deadlines at the top
of their list.

Steve
-- 
Steve Modica
Manager - Networking Drivers Group
"Give a man a fish, and he will eat for a day, hit him with a fish and
he leaves you alone" - me
