Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262621AbTCYMeC>; Tue, 25 Mar 2003 07:34:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262622AbTCYMeC>; Tue, 25 Mar 2003 07:34:02 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:27826
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262621AbTCYMeB>; Tue, 25 Mar 2003 07:34:01 -0500
Subject: Re: Boot/reboot cycle on startup
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Carl Gherardi <Carl.Gherardi@nautronix.com.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <CDF67C45E6F8384B996AC26A3B8057824F86A1@exch-fremantle.nautronix>
References: <CDF67C45E6F8384B996AC26A3B8057824F86A1@exch-fremantle.nautronix>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048600695.28493.1.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 25 Mar 2003 13:58:16 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-03-25 at 05:30, Carl Gherardi wrote:
> Hi all,
> 
> I've just been attempting to build bk-current for a via mini itx board
> with a VIA ezra 800Mhz CPU.

Try building a kernel for a lower CPU type than Athlon. C3 lacks a lot
of stuff the Athlon specific kernel uses

