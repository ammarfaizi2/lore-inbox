Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261407AbSIPMfO>; Mon, 16 Sep 2002 08:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261408AbSIPMfO>; Mon, 16 Sep 2002 08:35:14 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:17391
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261407AbSIPMfN>; Mon, 16 Sep 2002 08:35:13 -0400
Subject: Re: To Anyone with a Radeon 7500 board and the ali developer
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: alex14641@yahoo.com, TheUnforgiven@attbi.com, linux-kernel@vger.kernel.org
In-Reply-To: <20020915.220131.104193664.davem@redhat.com>
References: <20020916042625.55842.qmail@web40509.mail.yahoo.com> 
	<20020915.220131.104193664.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 16 Sep 2002 13:42:11 +0100
Message-Id: <1032180131.1191.7.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-09-16 at 06:01, David S. Miller wrote:
>    From: Alex Davis <alex14641@yahoo.com>
>    Date: Sun, 15 Sep 2002 21:26:25 -0700 (PDT)
> 
>    Just out of curiosity, do you have AGPMode set to any value other than "1"
>    in your XF86Config file? If so, try setting it to "1".
>    
> More importantly, set it to whatever value you have configured in
> your BIOS setup.  There are lots of chipsets for which the AGP
> mode change is not implemented fully/correctly in the AGP kernel
> drivers.

What is sad is the is an AGP standardised way to read this and XFree86
still, all these years on, doesn't do it by default.
