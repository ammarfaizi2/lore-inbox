Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129669AbRABRM0>; Tue, 2 Jan 2001 12:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129568AbRABRMH>; Tue, 2 Jan 2001 12:12:07 -0500
Received: from alcove.wittsend.com ([130.205.0.20]:49412 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S129464AbRABRMD>; Tue, 2 Jan 2001 12:12:03 -0500
Date: Tue, 2 Jan 2001 11:41:18 -0500
From: "Michael H. Warfield" <mhw@wittsend.com>
To: "Timothy A. DeWees" <whtdrgn@mail.cannet.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Good mailing list.
Message-ID: <20010102114118.D1974@alcove.wittsend.com>
Mail-Followup-To: "Timothy A. DeWees" <whtdrgn@mail.cannet.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <005001c074c7$ad43f5c0$7930000a@hcd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.2i
In-Reply-To: <005001c074c7$ad43f5c0$7930000a@hcd.net>; from whtdrgn@mail.cannet.com on Tue, Jan 02, 2001 at 09:24:11AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 02, 2001 at 09:24:11AM -0500, Timothy A. DeWees wrote:
> Hello,

>     Since it takes quite a it of time for me to deal with news groups, could
> someone please point me to a _LINUX_ news group that could help me with
> password sync between Unix and Windows.  I am using Microsofts password sync
> tool that comes with SFU 1.2.  I know I sould ask Micr$loth, but I have been
> for two mounths and thay refuse to help me.  I get ignored in the Micro$loth
> list, and I have a deadline.  Besides, I have found that most linux hackers
> know more about Micro$loth then the _GOOD_ people at Micro$sloth.

	You might be better off asking this up on one of the Samba
mailing lists.  We have options in Samba for simultaniously changing
both the Windows NT password hashes and the Unix hashes where Samba
is providing NT encrypted password authentication.  You can also use
pam_smb to use the NT password hashes for Unix password validation as
well.  In either case, it's more a generic Unix thing than it is a
specific Linux thing and you're more like to find your answers in the
Samba project.  Try samba@samba.org, samba-techincal@samba.org, or
samba-ntdom@samba.org.

> Thanks, and sorry for any disturbance!

> --
> Kind Regards,
> Timothy A. DeWees
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  (The Mad Wizard)      |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
