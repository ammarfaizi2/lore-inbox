Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132834AbRC2UY2>; Thu, 29 Mar 2001 15:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132836AbRC2UYS>; Thu, 29 Mar 2001 15:24:18 -0500
Received: from maila.telia.com ([194.22.194.231]:45833 "EHLO maila.telia.com")
	by vger.kernel.org with ESMTP id <S132834AbRC2UYI>;
	Thu, 29 Mar 2001 15:24:08 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@norran.net>
To: "Richard B. Johnson" <root@quark.analogic.com>,
   <linux-kernel@vger.kernel.org>
Subject: Re: Linux connectivity trashed.
Date: Thu, 29 Mar 2001 22:21:04 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <000701c0b854$f2cf4f10$1428b2cc@DJLAPTOP>
In-Reply-To: <000701c0b854$f2cf4f10$1428b2cc@DJLAPTOP>
MIME-Version: 1.0
Message-Id: <01032922210401.01482@jeloin>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I assume that it is ok to sue any company that forwards viruses too...
(not only the author...)

Are Raytheon suing the company were you work, or some
unknown/unnamed company made up by Microsoft?
(you were not specific about this)

/RogerL

On Thursday 29 March 2001 15:34, Richard B. Johnson wrote:
> This is for information only.
>
> Last week a standard RH distribution of  Linux was rooted from what looks
> like a Russian invasion. The penetration used the method taught in the CERT
> Advisory CA-2000-17.
>
> The intruder(s) then attempted  to perform additional penetrations from
> this site. One of  the sites attacked was alleged to be Raytheon. Raytheon
> makes products for national security such as guided missiles.
>
> I was told that Raytheon is now suing this company.  Therefore all Linux
> machines
> are being denied access to the Internet.

>
> The penetration occurred because somebody changed our  firewall
> configuration
> so that all of the non-DHCP addresses, i.e., all the real IP addresses had
> complete
> connectivity to the outside world. This meant that every Linux and Sun
> Workstation
> in this facility was exposed to tampering from anywhere in the world. This
> appears
> to be part of a plan to remove all non-DHCP machines by getting them
> trashed.
> In other words, we were set up to take a hard fall because no machine that
> allows
> NFS mounts  can be safely exposed to the outside world without blocking
> portmap.
>
> There is a concerted effort to eliminate both Sun Workstations and Linux
> machines
> as tools in this facility. This happens as the "yuppies",  who have never,
> ever, contributed
> to product development are Peter-Principled into positions of authority.
>
> The email addresses of  those who have declared that only Windows machines
> will
> be allowed access to the outside world are:
>
>     Thor T. Wallace   twallace@analogic.com
>     David Pothier       dpothier@analogic.com
>
> David Pothier was a beta tester for Windows/NT. Of course he wants all
> machines to
> be Windows and,  naturally, under his control.
>
> Thor Wallace is our new "security" administrator so I am told.
>
> The only  Linux  advocate in a position of authority is:
>
>    Alex Shekhel        ashekhel@analogic.com
>
> So,  now I hooked up my lap-top,  installed Windows.... and here I am. 
> Only windows
> machines are allowed to access the outside world.
>
>
>     Cheers,
>
>     Richard B. Johnson
>     Formally root@chaos.analogic.com
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Roger Larsson
Skellefteå
Sweden
