Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277689AbRJIBnJ>; Mon, 8 Oct 2001 21:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277690AbRJIBm7>; Mon, 8 Oct 2001 21:42:59 -0400
Received: from spog.gaertner.de ([194.45.135.2]:59922 "EHLO spog.gaertner.de")
	by vger.kernel.org with ESMTP id <S277689AbRJIBmq>;
	Mon, 8 Oct 2001 21:42:46 -0400
Date: Tue, 9 Oct 2001 03:43:14 +0200
From: Joerg Schumacher <schuma@gaertner.de>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PF_PACKET: packets out of order
Message-ID: <20011009034313.A22834@aunt.gaertner.de>
In-Reply-To: <200110082332.BAA16370@aunt.gaertner.de> <20011008.164337.31640467.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011008.164337.31640467.davem@redhat.com>; from davem@redhat.com on Mon, Oct 08, 2001 at 04:43:37PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2001 at 04:43:37PM -0700, David S. Miller wrote:
> [...]
> Anything which absolutely _requires_ all TX and RX packets to
> be in precise order, should really be fixed not to have such
> a weird restriction.

Do humans qualify as "anything" ;-)?  Until I saw the "LastTime jump
backward" warning in netramet I used to read the tcpdump output line 
by line without checking the timestamps.   Neither packet(7) nor 
tcpdump(1) indicate that I should do so. 

Regards, 
Joerg.

-- 
 Gaertner Datensysteme                         38114 Braunschweig 
 Joerg Schumacher                              Hamburger Str. 273a
 Tel: 0531-2335555                             Fax: 0531-2335556
