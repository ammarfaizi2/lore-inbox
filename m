Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932547AbWCHKDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932547AbWCHKDy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 05:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932549AbWCHKDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 05:03:54 -0500
Received: from xproxy.gmail.com ([66.249.82.195]:40554 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932547AbWCHKDx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 05:03:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hlNqj4e+b0h6pD/fcI3NMGT+IM+tAJsQ6jusbUsj8KFO3x5OiMenoWS04murBCehUEj8aV2NsbOuEDUiUUd5iPsxC7Qflm0c/E5X6xmmbBCS7TGuYci4c6q8JgZii7pat66lV18GIpOdvpFIaeh1VvfqrinZHvJPDil2Qu/nSdc=
Message-ID: <ec92bc30603080203rb4f5e7bvea993a44ceb5d3ca@mail.gmail.com>
Date: Wed, 8 Mar 2006 15:33:52 +0530
From: "Anshuman Gholap" <anshu.pg@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [future of drivers?] a proposal for binary drivers.
Cc: "Jan Knutar" <jk-lkml@sci.fi>
In-Reply-To: <200603081151.33349.jk-lkml@sci.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <ec92bc30603080135j5257c992k2452f64752d38abd@mail.gmail.com>
	 <200603081151.33349.jk-lkml@sci.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jan,

you said  quote, "The real question is: Why do binary-only drivers
need to exist?"

super super super nice question.

ok here is the deal, My bro who is a doctor and has lenovo laptop,
buys lets say dlink pcmcia wifi card , and opens the box, gets the
hardware out and the software  cd out, all he sees is windows related
drivers and documentation, he and any person like him wont even bother
how to plug this in ubuntu linux (which i almost mind-controlled him
into installing it) , he knowing me as a linux person will keep
bugging me, when i tell him to install a kernel source compile it to
allow 16k stack, install ndiswrapper and load the windows driver and
compile install gtk-wifi app and get wifi network.  he might admit me
into hospital for talk_while_geek with a normal person.

if there was binary allowed (with any license) maybe dlink themself
would build a driver, make documentation and provide it on CD, just
see how much effort would be saved and in end he would get more time
to treat his patients.

I have thousands of similar scenarios. Even I wont mind the luxury of
making hardware just working and not going to google>>download src>>if
bug/error found>>go to forums post thread>>hang on irc and bug
ppl>>get more things compiled done >>if work then enjoy>> or wait for
the philanthropic coder to solve bug and release new ver.

Best regards,
Anshuman Gholap.
