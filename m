Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289053AbSBSASp>; Mon, 18 Feb 2002 19:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289055AbSBSASf>; Mon, 18 Feb 2002 19:18:35 -0500
Received: from due.stud.ntnu.no ([129.241.56.71]:46533 "EHLO due.stud.ntnu.no")
	by vger.kernel.org with ESMTP id <S289053AbSBSASZ>;
	Mon, 18 Feb 2002 19:18:25 -0500
Date: Tue, 19 Feb 2002 01:18:23 +0100
From: =?iso-8859-1?Q?Thomas_Lang=E5s?= <tlan@stud.ntnu.no>
To: linux-kernel@vger.kernel.org
Subject: Re: Broadcom 5700/5701 Gigabit Ethernet Adapters
Message-ID: <20020219011823.A28861@stud.ntnu.no>
Reply-To: linux-kernel@vger.kernel.org
In-Reply-To: <E16bhwo-0007GZ-00@bronto.zrz.TU-Berlin.DE> <3C6D07B9.596AD49E@mandrakesoft.com> <20020215153604.A29642@stud.ntnu.no> <20020215.122047.41633873.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020215.122047.41633873.davem@redhat.com>; from davem@redhat.com on Fri, Feb 15, 2002 at 12:20:47PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller:
> No, we've been reverse engineering the hardware using the sources of
> Broadcom's driver.  This is why the work is taking so long.

Ok, I've downloaded the driver, and tried building as a modue to a
2.4.17-kernel. It segfaulted when I tried loading it (since it says it's not
done, I wasn't expecting it to work :).  However, my question is; how do you
guys develope network drivers, for instance?  I mean, in order to test a new
version (after the first has segfaulted), I need to reboot.  

I've got the broadcom-version dated 2th january 2002, and wanted to try and
implement small parts of missing code, mostly for educational purposes to
learn more about kernel programming.

-- 
Thomas
