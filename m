Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319128AbSIDLKg>; Wed, 4 Sep 2002 07:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319130AbSIDLKg>; Wed, 4 Sep 2002 07:10:36 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:45299
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319128AbSIDLKf>; Wed, 4 Sep 2002 07:10:35 -0400
Subject: Re: Linux on Toshiba Libretto 70CT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John Weber <john.weber@linux.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D7563B2.2090707@linux.org>
References: <3D7563B2.2090707@linux.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 04 Sep 2002 12:15:32 +0100
Message-Id: <1031138132.2796.24.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-09-04 at 02:36, John Weber wrote:
> The kernel locks up completely whenever I launch any particularly large 
> application under X (xterm is fine, netscape locks up the box).
> I've confirmed that this isn't just X locking up, as the machine is 
> completely frozen (doesn't respond to pings, doesn't respond to three 
> finger salute, etc).

Can you duplicate this with the vesa and/or vga16 drivers ?
