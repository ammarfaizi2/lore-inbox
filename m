Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132143AbRAEPnp>; Fri, 5 Jan 2001 10:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132258AbRAEPng>; Fri, 5 Jan 2001 10:43:36 -0500
Received: from nmail.corel.com ([209.167.40.11]:23225 "EHLO nsmail.corel.com")
	by vger.kernel.org with ESMTP id <S129383AbRAEPn2>;
	Fri, 5 Jan 2001 10:43:28 -0500
Subject: Re: kernel network problem ?
From: "Richard Rak" <richardr@corel.com>
To: Nicolas Parpandet <nparpand@perinfo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <000d01c07724$8fa531f0$8900030a@nicolasp>
Content-Type: text/plain
X-Mailer: Evolution 0.8 (Developer Preview)
Date: 05 Jan 2001 10:49:31 -0500
Mime-Version: 1.0
Message-ID: <7744FF5310E6.AAA66E7@nsmail.corel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Try typing "echo 0 > /proc/sys/net/ipv4/tcp_ecn" at a shell to
    disable TPC ECN support.



On 05 Jan 2001 15:34:07 +0100, Nicolas Parpandet wrote:
> 
> Hi all,
> 
> I'm testing 2.4 series for few weeks,
> even the last prerelease
> 
> I've seen stranges things  :
> 
> I cannot access to some ips adresses ! :
> in http or in smtp using "konqueror", "netscape",
> "mail",  "telnet 25".
> 
> I cannot login to hotmail (in the web page:http) 
> or send mail (smtp) to hotmail users (don't blame me !!)
> All the others network things works well, the network in general seems
> good only very few sites like hotmail doesn't works.
> 
> And only with 2.4 series !! not with 2.2 ...
> 
> maybe it's a glibc or kernel issue, I'dont know.
> I have an intel SMP motherboard connected to the net (cable) 
> with a PCI realtek 8019.
> 
> I didn't analyse packets sent. If somebody else have the
> same problems ...
> 
> Nicolas.
> 
> Sorry for my poor english.
> 
> PS: funny "bug" isn't it ? (hotmail !)
> PS2: thanks for all, very good job done, 
>       2.4 is very fast and seems stable.
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/



-- 
        Richard Rak
        (richardr@corel.com)
        Software Engineer
        A+ Certified Service Technician

        Experience CorelDRAW 10 Graphics Suite - creative power with an attitude. 
        Visit http://www.corel.com/draw10

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
