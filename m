Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315485AbSG3Rt1>; Tue, 30 Jul 2002 13:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315779AbSG3Rt1>; Tue, 30 Jul 2002 13:49:27 -0400
Received: from air-2.osdl.org ([65.172.181.6]:42900 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S315485AbSG3Rt0>;
	Tue, 30 Jul 2002 13:49:26 -0400
Message-Id: <200207301752.g6UHqjo32751@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Axel Siebenwirth <axel@hh59.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Testing of filesystems 
In-Reply-To: Your message of "Tue, 30 Jul 2002 11:49:02 +0200."
             <20020730094902.GA257@prester.freenet.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 30 Jul 2002 10:52:45 -0700
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
> 
> I wonder what a good way is to stress test my JFS filesystem. Is there a tool
> that does something like that maybe? Dont't want performance testing, just
> all kinds of stress testing to see how the filesystem "is" and to check
> integrity and functionality.
> What are you filesystem developers use to do something like that?
> 

You can use the Scalable  Test Platform at the OSDL. 
We currently have iozone and tiobench test which support JFS, and
we're looking to add other tests.  For details, see 
http://www.osdl.org/stp/
cliffw

> Thanks,
> Axel
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


