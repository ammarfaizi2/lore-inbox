Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265308AbSKEBO2>; Mon, 4 Nov 2002 20:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267700AbSKEBO1>; Mon, 4 Nov 2002 20:14:27 -0500
Received: from rrzs2.rz.uni-regensburg.de ([132.199.1.2]:3795 "EHLO
	rrzs2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S265308AbSKEBOZ>; Mon, 4 Nov 2002 20:14:25 -0500
Date: Tue, 5 Nov 2002 02:20:57 +0100
From: Christian Guggenberger 
	<christian.guggenberger@physik.uni-regensburg.de>
To: linux-kernel@vortech.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-rc1 and udma with VIA kt8235
Message-ID: <20021105022057.A18726@pc9391.uni-regensburg.de>
References: <20021105002551.A16087@pc9391.uni-regensburg.de> <20021105002750.C16087@pc9391.uni-regensburg.de> <200211042002.20797.linux-kernel@vortech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
In-Reply-To: <200211042002.20797.linux-kernel@vortech.net>; from linux-kernel@vortech.net on Tue, Nov 05, 2002 at 02:02:20 +0100
X-Mailer: Balsa 1.2.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05 Nov 2002 02:02:20 Joshua Jackson wrote:
> I have been using the following modification for a couple of weeks now to
> both
> the 2.4.19 and 2.4.20-pre11 kernels on an MSI KT3 Ultra2 board (has the 8235
> southbridge) and have not had any problems with the hard drives or DVD/CDRW
> drives in the system running in UDMA mode.
> 
> The code modification comes from a patch that was posted to the list a while
> back by Vojtech.
> 

thanks,

I knew about that patch. I only wanted to point out, that it would be nice to 
see it in mainline 2.4.20, as the number of mobos with VIA KT400/8235 and 
KT333/8235 is increasing:-)

Christian
