Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269200AbTGORj3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 13:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268938AbTGORig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 13:38:36 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:21447
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S269175AbTGORhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 13:37:13 -0400
Subject: Re: 2.6.0-test1-ac1 Matrox Compile Error
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: James Simmons <jsimmons@infradead.org>
Cc: Dave Jones <davej@codemonkey.org.uk>, dank@reflexsecurity.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0307151833310.7746-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0307151833310.7746-100000@phoenix.infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058291363.3845.53.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 15 Jul 2003 18:49:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-07-15 at 18:43, James Simmons wrote:
>    Also doing this kind of thing only covers up broken framebuffer 
> drivers. Unfortunetly its going to take me months to cleanup and make the 
> fbdev drivers behave right. 

We don't have months. Should we be talking about reverting to the rather
solid 2.4 framebuffer side for 2.6 in this case ?

