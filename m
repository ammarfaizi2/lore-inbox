Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272641AbTG1HbV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 03:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272687AbTG1HbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 03:31:21 -0400
Received: from portraits.wsisiz.edu.pl ([213.135.44.34]:64106 "EHLO
	portraits.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id S272641AbTG1HbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 03:31:20 -0400
Date: Mon, 28 Jul 2003 09:46:14 +0200 (CEST)
From: Lukasz Trabinski <lukasz@lt.wsisiz.edu.pl>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: where are the sources :-)
In-Reply-To: <32922.4.4.25.4.1059361414.squirrel@www.osdl.org>
Message-ID: <Pine.LNX.4.53.0307280944420.1562@lt.wsisiz.edu.pl>
References: <Pine.LNX.4.44.0307271026001.3400-100000@home.osdl.org>       
 <200307271924.h6RJOwn1003529@lt.wsisiz.edu.pl> <32922.4.4.25.4.1059361414.squirrel@www.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Jul 2003, Randy.Dunlap wrote:
> > Does anybody can generate incr patch (2.6.0-test1 -> 2.6.0-test2)? :-) Thank
> > you. :)
> 
> You mean like www.kernel.org/pub/linux/kernel/v2.6/patch-2.6.0-test2.bz2 ?

something like:
diff -urN linux-2.6.0-test1 linux-2.6.0-test2 >patch-2.6.0-test1-2.6.0-test2
gzip patch-2.6.0-test1-2.6.0-test2

-- 
*[ £ukasz Tr±biñski ]*
