Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129749AbRAIMQV>; Tue, 9 Jan 2001 07:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129773AbRAIMQL>; Tue, 9 Jan 2001 07:16:11 -0500
Received: from alcove.wittsend.com ([130.205.0.20]:65288 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S129749AbRAIMQF>; Tue, 9 Jan 2001 07:16:05 -0500
Date: Tue, 9 Jan 2001 07:15:41 -0500
From: "Michael H. Warfield" <mhw@wittsend.com>
To: Mike <mike@khi.sdnpk.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-irda@pasta.cs.UiT.No" <linux-irda@pasta.cs.UiT.No>
Subject: Re: Which Bind version..
Message-ID: <20010109071541.A31423@alcove.wittsend.com>
Mail-Followup-To: Mike <mike@khi.sdnpk.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-irda@pasta.cs.UiT.No" <linux-irda@pasta.cs.UiT.No>
In-Reply-To: <3A5972B4.E69C7B36@khi.sdnpk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.2i
In-Reply-To: <3A5972B4.E69C7B36@khi.sdnpk.org>; from mike@khi.sdnpk.org on Mon, Jan 08, 2001 at 12:56:37PM +0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2001 at 12:56:37PM +0500, Mike wrote:
> Hi!!

> I wanna install Bind on my DNS. Which Bind version is most stabel and
> secure.

	9.0.1 is the latest release in the 9.x series and if you are
interested in "SecureDNS", that's the way to go.  I'm currently running
9.1.0beta2, and it seems rock solid to me.  There is also 8.2.2P7 if
you want to stick the the older 8.x series, but I certainly wouldn't
if I were setting up a new DNS server.  The 4.x series is totally
deprecated at this point.  Personally, I wouldn't use anything less
than 9.0.1 and I currently support over 100 domains on my servers
(my partner runs a hosting service).

> Regards,
> Nauman Ansari

	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  (The Mad Wizard)      |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
