Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277962AbRJIUyY>; Tue, 9 Oct 2001 16:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277963AbRJIUyC>; Tue, 9 Oct 2001 16:54:02 -0400
Received: from cs181196.pp.htv.fi ([213.243.181.196]:16000 "EHLO
	cs181196.pp.htv.fi") by vger.kernel.org with ESMTP
	id <S277962AbRJIUx4>; Tue, 9 Oct 2001 16:53:56 -0400
Message-ID: <3BC363FF.3F911E5E@welho.com>
Date: Tue, 09 Oct 2001 23:54:23 +0300
From: Mika Liljeberg <Mika.Liljeberg@welho.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Yaroslav Popovitch <yp@sot.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Which switch should be enabled in kernel to support global 
 IPv6forwarding
In-Reply-To: <Pine.LNX.4.10.10110092027360.27505-100000@ares.sot.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yaroslav Popovitch wrote:
> 
> ASAP,please

sysctl -w net.ipv6.conf.all.forwarding=1

Regards,

	MikaL
