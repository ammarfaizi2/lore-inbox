Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263026AbRFDXve>; Mon, 4 Jun 2001 19:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261490AbRFDXvZ>; Mon, 4 Jun 2001 19:51:25 -0400
Received: from femail15.sdc1.sfba.home.com ([24.0.95.142]:49057 "EHLO
	femail15.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S263026AbRFDXvV>; Mon, 4 Jun 2001 19:51:21 -0400
Date: Mon, 4 Jun 2001 19:51:08 -0400
From: Tom Vier <tmv5@home.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.2 <-> 2.4.5-ac5 tcp too slow
Message-ID: <20010604195108.A622@zero>
In-Reply-To: <20010604182834.A2486@zero>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010604182834.A2486@zero>; from tmv5@home.com on Mon, Jun 04, 2001 at 06:28:34PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i tracked it down to the 8139 driver in 2.4.

On Mon, Jun 04, 2001 at 06:28:34PM -0400, Tom Vier wrote:
> has the same effect) and an alpha pws 500 running 2.4.5-ac5. tcp starts slow
> and get slower. it's not a 10/100 or duplex issue. icmp goes at full speed.

-- 
Tom Vier <tmv5@home.com>
DSA Key id 0x27371A2C
