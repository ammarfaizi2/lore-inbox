Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314396AbSE1OCk>; Tue, 28 May 2002 10:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314702AbSE1OCj>; Tue, 28 May 2002 10:02:39 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:35578 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314396AbSE1OCi>; Tue, 28 May 2002 10:02:38 -0400
Subject: Re: Kernel (2.4.19-pre8) hang
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Frederik Nosi <fredi@e-salute.it>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1022593284.1732.22.camel@linux>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 28 May 2002 16:05:32 +0100
Message-Id: <1022598332.4123.84.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-05-28 at 14:41, Frederik Nosi wrote:
> Now if you want me to try something else, I'll wait 2/3 hours for a 
> mail. After that I'll reboot that pc hopping that my partitions arent
> wihpped :)

I think bang the switch, fsck it and then send a detailed summary
including the disk/controller info to andre@linux-ide.org, and since its
VIA chipset also cc Vojtech (see MAINTAINERS)

