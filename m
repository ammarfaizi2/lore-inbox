Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129325AbQLSRIK>; Tue, 19 Dec 2000 12:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129538AbQLSRIB>; Tue, 19 Dec 2000 12:08:01 -0500
Received: from [199.239.160.155] ([199.239.160.155]:13061 "EHLO
	tenchi.datarithm.net") by vger.kernel.org with ESMTP
	id <S129325AbQLSRHt>; Tue, 19 Dec 2000 12:07:49 -0500
Date: Tue, 19 Dec 2000 08:56:39 -0800
From: Robert Read <rread@datarithm.net>
To: Peter Rival <frival@zk3.dec.com>
Cc: linux-kernel@vger.kernel.org, axp-list <axp-list@redhat.com>
Subject: Re: QLogicFC problems with 2.4.x?
Message-ID: <20001219085639.C15413@tenchi.datarithm.net>
Mail-Followup-To: Peter Rival <frival@zk3.dec.com>,
	linux-kernel@vger.kernel.org, axp-list <axp-list@redhat.com>
In-Reply-To: <3A3E8096.3010606@zk3.dec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A3E8096.3010606@zk3.dec.com>; from frival@zk3.dec.com on Mon, Dec 18, 2000 at 04:24:38PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The driver loads for me on 2.4 on Intel, but I don't have access to an
Alpha right now. Have you tried Mathew Jacob's driver?  It looks like
it supports Alpha.

http://www.feral.com/isp.html

robert

On Mon, Dec 18, 2000 at 04:24:38PM -0500, Peter Rival wrote:
> Hi,
> 
>    I was just lent a QLogic ISP2200 FC adapter and have been having a 
> bear of a time trying to get it to work on my Alpha ES40 and GS80.  I've 
> tried both the qlogicfc (with standard kernel) and qla2x00 (from QLogic 
> and Compaq) driver both built-in and as modules but neither of them are 
> working.  Has anyone had success with later (I'm using 2.4.0-test11) 2.4 
> kernels and the QLogic FC adapter?  I'm currently plugged into a Brocade 
> switch (Plaides I, I believe) which is also attached to two pair of 
> HSG80 FC RAID controllers.  AFAIK, the 2200 is supposed to work with an 
> FC fabric, so this should work, right?  Can anyone offer any 
> assistance?  Thanks!
> 
>   - Pete
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
