Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264153AbTFCUZX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 16:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264146AbTFCUZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 16:25:23 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:6785
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264153AbTFCUZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 16:25:23 -0400
Subject: Re: Linux 2.4.21-rc7
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: lk@trolloc.com
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0306031214140.22989-100000@ip-64-7-1-79.dsl.lax.megapath.net>
References: <Pine.LNX.4.33.0306031214140.22989-100000@ip-64-7-1-79.dsl.lax.megapath.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054669251.9359.53.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 03 Jun 2003 20:40:52 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-06-03 at 20:15, lk@trolloc.com wrote:
> Unfortunately I just committed my test box to production and can't test 
> Alan's SiImage fixes in rc6-ac2, but if they pan out, please try to 
> include them in -rc8 as well.

You could add the dma autoenable but the rest should be avoided

