Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282647AbRK0TWr>; Tue, 27 Nov 2001 14:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282664AbRK0TW2>; Tue, 27 Nov 2001 14:22:28 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:30447 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S282647AbRK0TWY>; Tue, 27 Nov 2001 14:22:24 -0500
Date: Tue, 27 Nov 2001 11:15:01 -0800
From: Chris Wright <chris@wirex.com>
To: Heikki Levanto <heikki@indexdata.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.16: "Address family not supported" on RH IBM T23
Message-ID: <20011127111501.A9297@figure1.int.wirex.com>
Mail-Followup-To: Heikki Levanto <heikki@indexdata.dk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011127200522.B27480@indexdata.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011127200522.B27480@indexdata.dk>; from heikki@indexdata.dk on Tue, Nov 27, 2001 at 08:05:22PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Heikki Levanto (heikki@indexdata.dk) wrote:
> 
> Large problem: Network won't come up. Says:
> > Cannot open netlink socket: Address family not supported by protocol

did you enable CONFIG_NETLINK _and_ CONFIG_RTNETLINK?

-chris
