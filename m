Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266015AbRGCVJx>; Tue, 3 Jul 2001 17:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266017AbRGCVJd>; Tue, 3 Jul 2001 17:09:33 -0400
Received: from smtp.mailbox.co.uk ([195.82.125.32]:36268 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S266015AbRGCVJ1>; Tue, 3 Jul 2001 17:09:27 -0400
Date: Tue, 3 Jul 2001 22:09:24 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Stuart MacDonald <stuartm@connecttech.com>
Cc: James R Bruce <bruce+@andrew.cmu.edu>, linux-kernel@vger.kernel.org,
        tytso@mit.edu
Subject: Re: serial port O_SYNC functionality in 2.4.5
Message-ID: <20010703220924.C31954@flint.arm.linux.org.uk>
In-Reply-To: <IvEWK2Rz00018DeGw=@andrew.cmu.edu> <040a01c10400$9c6a2e40$294b82ce@connecttech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <040a01c10400$9c6a2e40$294b82ce@connecttech.com>; from stuartm@connecttech.com on Tue, Jul 03, 2001 at 04:42:00PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2001 at 04:42:00PM -0400, Stuart MacDonald wrote:
> Best way to get this in the serial driver is to do some patches for it
> and send them to Ted. :-)

Please copy them to me as well.  The ARM tree has a core uart driver
in currently which handles several different types of serial ports.

Thanks.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

