Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263259AbTIAUeK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 16:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263267AbTIAUeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 16:34:09 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:56587 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S263259AbTIAUeI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 16:34:08 -0400
Date: Mon, 1 Sep 2003 22:34:05 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Martin Schlemmer <azarah@gentoo.org>
Cc: Valdis.Kletnieks@vt.edu, Boszormenyi Zoltan <zboszor@freemail.hu>,
       Andrew Morton <akpm@osdl.org>, KML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test4-mm3
Message-ID: <20030901203405.GA25363@mars.ravnborg.org>
Mail-Followup-To: Martin Schlemmer <azarah@gentoo.org>,
	Valdis.Kletnieks@vt.edu, Boszormenyi Zoltan <zboszor@freemail.hu>,
	Andrew Morton <akpm@osdl.org>, KML <linux-kernel@vger.kernel.org>
References: <3F4F22D3.9080104@freemail.hu> <200308291300.h7TD049n022785@turing-police.cc.vt.edu> <1062168946.19599.114.camel@workshop.saharacpt.lan> <200308291553.h7TFrcGG009390@turing-police.cc.vt.edu> <1062447809.5275.7.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062447809.5275.7.camel@nosferatu.lan>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 01, 2003 at 10:23:30PM +0200, Martin Schlemmer wrote:
> 
> Hmm, this will only work with RH based systems (not using here).  I
> think the best way is how Andrew did it to just warn if depmod fails.
> You may agree to disagree if need be :)

Andrew's version is already in mainline.

	Sam
