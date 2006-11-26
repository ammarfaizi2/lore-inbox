Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935560AbWKZTW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935560AbWKZTW6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 14:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935561AbWKZTW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 14:22:57 -0500
Received: from khc.piap.pl ([195.187.100.11]:52205 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S935560AbWKZTW4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 14:22:56 -0500
To: Adrian Bunk <bunk@stusta.de>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [2.6 patch] make hdlc_setup() static again
References: <20060625205137.GH23314@stusta.de>
	<m3veqnlnsh.fsf@defiant.localdomain> <20061125191653.GJ3702@stusta.de>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sun, 26 Nov 2006 20:22:53 +0100
In-Reply-To: <20061125191653.GJ3702@stusta.de> (Adrian Bunk's message of "Sat, 25 Nov 2006 20:16:53 +0100")
Message-ID: <m3odqu812q.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> writes:

> It's still not used...
>
> So let's unexport it again until some driver that actually uses it shows up.

Fair enough.
-- 
Krzysztof Halasa
