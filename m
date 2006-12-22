Return-Path: <linux-kernel-owner+w=401wt.eu-S1423187AbWLVHAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423187AbWLVHAx (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 02:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423191AbWLVHAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 02:00:53 -0500
Received: from gw.goop.org ([64.81.55.164]:55583 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423187AbWLVHAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 02:00:52 -0500
Message-ID: <458B82A2.9030708@goop.org>
Date: Thu, 21 Dec 2006 23:00:50 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Frederik Deweerdt <deweerdt@free.fr>, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] ptrace: make {put,get}reg work again for gs and fs
References: <20061214225913.3338f677.akpm@osdl.org>	<20061221183518.GA18827@slug>	<458ADEDD.8010903@goop.org>	<20061221215942.GC18827@slug>	<458B3C51.4030905@goop.org>	<20061221181108.6cede9ba.akpm@osdl.org>	<20061222060618.GD18827@slug> <20061221225414.de09c7df.akpm@osdl.org>
In-Reply-To: <20061221225414.de09c7df.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> OK, but you're using -mm, yes?  And -mm has (the rather irritating)
> convert-i386-pda-code-to-use-%fs.patch in it.
>
> So perhaps your fix is a -mm-only thing?
>   

Yes, I think that's true.


    J
