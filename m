Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129150AbQJ0KcP>; Fri, 27 Oct 2000 06:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129155AbQJ0KcF>; Fri, 27 Oct 2000 06:32:05 -0400
Received: from isis.its.uow.edu.au ([130.130.68.21]:46293 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129150AbQJ0Kbz>; Fri, 27 Oct 2000 06:31:55 -0400
Message-ID: <39F95995.FA84F9D9@uow.edu.au>
Date: Fri, 27 Oct 2000 21:31:49 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Timothy Ball <timball@tux.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: VM-global-2.2.18pre17-7
In-Reply-To: <Pine.LNX.4.21.0010251633080.3324-100000@freak.distro.conectiva> <39F84B64.5935C12@ovh.net> <39F8566D.51561CB3@profmakx.de> <39F85A09.DA88452F@ovh.net>,
		<39F85A09.DA88452F@ovh.net>; from oles@ovh.net on Thu, Oct 26, 2000 at 06:21:29PM +0200 <20001026155323.E12432@gwyn.tux.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Ball wrote:
> 
> I get similar eth0 hangs using a 3c59x. Though outside of rebooting I
> have no clue how to get networking going again.

If this is 2.2.17 then please send me the details.

If it's something earlier then you will need to use the 2.2.17 driver. 
Or, even better, the 2.2.18 candidate:
http://www.uow.edu.au/~andrewm/linux/3c59x-2.2.18-pre16-1.gz
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
