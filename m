Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129534AbRADWth>; Thu, 4 Jan 2001 17:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129523AbRADWt1>; Thu, 4 Jan 2001 17:49:27 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:4101 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S129428AbRADWtP>; Thu, 4 Jan 2001 17:49:15 -0500
Date: Thu, 4 Jan 2001 23:45:23 +0100
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Journaling: Surviving or allowing unclean shutdown?
Message-ID: <20010104234522.H888@arthur.ubicom.tudelft.nl>
In-Reply-To: <20010104213355.707A651AA@Nicole.muc.suse.de> <Pine.LNX.3.95.1010104155136.18796A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.95.1010104155136.18796A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Thu, Jan 04, 2001 at 03:59:40PM -0500
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2001 at 03:59:40PM -0500, Richard B. Johnson wrote:
> Well they do! It's just not allowed for us (the users) to know that they
> __didn't__ run completely out of power!  If the thing is so dead
> that it won't recharge, it still has 'power' (enough to keep static RAM
> alive). Just remove the battery, wait about 120 seconds for a capacitor
> to discharge,  and, zap, no more stored phone numbers. Static RAM with
> an electrolytic capacitor, isolated with a diode, takes so little power
> that you can normally change defective batteries if you don't take
> too long.

<offtopic>
Not over here in Europe where we use GSM phones. The phone numbers,
phone settings, and SMS (Small Message Services) messages are all
stored in the flash memory on the SIM (Subscriber Identity Module, a
1x2.5 cm chip card).
</offtopic>


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
