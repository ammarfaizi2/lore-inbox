Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129682AbQLIFPA>; Sat, 9 Dec 2000 00:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129784AbQLIFOu>; Sat, 9 Dec 2000 00:14:50 -0500
Received: from james.kalifornia.com ([208.179.0.2]:64316 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S129682AbQLIFOr>; Sat, 9 Dec 2000 00:14:47 -0500
Message-ID: <3A31B8CC.7030604@kalifornia.com>
Date: Fri, 08 Dec 2000 20:45:00 -0800
From: Ben Ford <ben@kalifornia.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-test10 i586; en-US; m18) Gecko/20001207
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Lattner <sabre@nondot.org>
CC: linux-kernel@vger.kernel.org, orbit-list@gnome.org,
        korbit-cvs@lists.sourceforge.net
Subject: Re: ANNOUNCE: Linux Kernel ORB: kORBit
In-Reply-To: <Pine.LNX.4.21.0012081626140.7741-100000@www.nondot.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Lattner wrote:

> This email is here to announce the availability of a port of ORBit (the
> GNOME ORB) to the Linux kernel.  This ORB, named kORBit, is available from
> our sourceforge web site (http://korbit.sourceforge.net/).  A kernel ORB
> allows you to write kernel extensions in CORBA and have the kernel call
> into them, or to call into the kernel through CORBA.  This opens the door
> to a wide range of experiments/hacks:
> 
> * We can now write device drivers in perl, and let them run on the iMAC
>   across the hall from you. :)

Why would you *ever* want to write a device driver in perl???

-b

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
