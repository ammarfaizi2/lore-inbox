Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279939AbRJ3MKY>; Tue, 30 Oct 2001 07:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279938AbRJ3MKP>; Tue, 30 Oct 2001 07:10:15 -0500
Received: from mailg.telia.com ([194.22.194.26]:59337 "EHLO mailg.telia.com")
	by vger.kernel.org with ESMTP id <S279936AbRJ3MJy>;
	Tue, 30 Oct 2001 07:09:54 -0500
Date: Tue, 30 Oct 2001 13:05:05 +0100
From: Johan <jo_ni@telia.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Still having problems with eepro100
Message-Id: <20011030130505.20b3a688.jo_ni@telia.com>
In-Reply-To: <20011030125720.A469@stud.ntnu.no>
In-Reply-To: <20011030123927.74e26501.jo_ni@telia.com>
	<20011030125720.A469@stud.ntnu.no>
X-Mailer: Sylpheed version 0.6.4 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Oct 2001 12:57:20 +0100
Thomas Langås <tlan@stud.ntnu.no> wrote:

> Johan:
> > Does anyone except me still having problems with the eepro100 drivers ?
> 
> Yes, as I've mentioned in a earlier thread on this list, we have problems,
> but trying the e100-driver from intel doesn't seem to help either (I'm
> running tests now, and so far, they don't look very promising).

Yes, I have read it, but it was a while ago and I thought the problem
were sovled.

> I'm experiensing the:
> eth0: Card reports no resources
> 
> And, then a hang of at least a minute before the network connection is
> restored. All my connections are 100Mbit full duplex, and the error comes
> when doing heavy traffic. (Try bonnie++ over NFS, for instance).

Yes, its the same for me.

Now I'll know that the driver still have problems.
Thanks for your quick answear.

-- 
// Johan
