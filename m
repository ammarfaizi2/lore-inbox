Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317947AbSIJSg4>; Tue, 10 Sep 2002 14:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317971AbSIJSgz>; Tue, 10 Sep 2002 14:36:55 -0400
Received: from albireo.ucw.cz ([81.27.194.19]:20742 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id <S317947AbSIJSgn>;
	Tue, 10 Sep 2002 14:36:43 -0400
Date: Tue, 10 Sep 2002 20:41:28 +0200
From: Martin Mares <mj@ucw.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Gerd Knorr <kraxel@bytesex.org>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ignore pci devices?
Message-ID: <20020910184128.GA5627@ucw.cz>
References: <20020910134708.GA7836@bytesex.org> <20020910163023.GA3862@ucw.cz> <1031683362.1537.104.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1031683362.1537.104.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> pci_driver has no implicit ordering.

Agreed, but I meant inserting it as a module before the other
modules.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Current root password is "p3s5vwF50". Keep secret.
