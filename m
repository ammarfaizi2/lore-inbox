Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932947AbWFZT2T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932947AbWFZT2T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 15:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932945AbWFZT2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 15:28:19 -0400
Received: from khc.piap.pl ([195.187.100.11]:56021 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S932944AbWFZT2S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 15:28:18 -0400
To: Adrian Bunk <bunk@stusta.de>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: -git: Why is drivers/net/wan/hdlc_generic.c:hdlc_setup() exported?
References: <20060625205137.GH23314@stusta.de>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Mon, 26 Jun 2006 21:28:14 +0200
In-Reply-To: <20060625205137.GH23314@stusta.de> (Adrian Bunk's message of "Sun, 25 Jun 2006 22:51:38 +0200")
Message-ID: <m3veqnlnsh.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> writes:

>    hdlc_setup() is now EXPORTed as per David's request.
>
> Is a usage of this export pending for the near future

I'm told it is.
-- 
Krzysztof Halasa
