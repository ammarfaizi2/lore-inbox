Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262235AbUCIWZW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 17:25:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262250AbUCIWZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 17:25:21 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:46875 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S262235AbUCIWZS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 17:25:18 -0500
Date: Tue, 9 Mar 2004 23:26:24 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Kliment Yanev <Kliment.Yanev@helsinki.fi>
Cc: Sam Ravnborg <sam@ravnborg.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Nokia c110 driver
Message-ID: <20040309222624.GA2046@mars.ravnborg.org>
Mail-Followup-To: Kliment Yanev <Kliment.Yanev@helsinki.fi>,
	Sam Ravnborg <sam@ravnborg.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
	linux-kernel@vger.kernel.org
References: <404C8A35.3020308@helsinki.fi> <20040308090640.2d557f9e.rddunlap@osdl.org> <404CF77A.2050301@helsinki.fi> <20040308150907.4db68831.rddunlap@osdl.org> <404D0032.1000807@helsinki.fi> <20040308153602.331f079e.rddunlap@osdl.org> <404DC622.7020300@helsinki.fi> <20040309080409.49fc0358.rddunlap@osdl.org> <20040309192713.GA2182@mars.ravnborg.org> <404E4006.5020604@helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <404E4006.5020604@helsinki.fi>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Is there some kbuild howto somewhere? If not, one is definitely
> necessary I think. I had never heard about the _shipped thing (and I did
> look around a bit and read and reread the driver porting guide chapter
> on kbuild).
>From Documentation/kbuild/makefiles.txt:

=== 10 TODO

- Describe how kbuild support shipped files with _shipped.

I'm slowly writing something with main focus on external modules.
This text will include the trick with _shipped.
But until this is finished no luck.

	Sam
