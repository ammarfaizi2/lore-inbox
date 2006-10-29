Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751708AbWJ2PuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751708AbWJ2PuG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 10:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751730AbWJ2PuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 10:50:06 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:2215 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751708AbWJ2PuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 10:50:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=pb/6J4k23NhuqW8NluJTxtYhpiyxxsh1U7gE1IOg0CbgHjNPsqarvL9taR/uod9IaVhLRBwRzXKK9fc3PEEcwKhRUu1WJmDnSTeh8AqxO0DF2BEaJcvMLoKhlfgEj4pKgd3dmDXP/vwYZZePKOGD8thbXnq6iqV8KR09j4S38yM=
Date: Sun, 29 Oct 2006 16:49:58 +0100
From: Luca Tettamanti <kronos.it@gmail.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: why "probe_kernel_address()", not "probe_user_address()"?
Message-ID: <20061029154957.GA25370@dreamland.darkstar.lan>
References: <20061028203014.GA7183@dreamland.darkstar.lan> <Pine.LNX.4.64.0610281659250.4741@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610281659250.4741@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Sat, Oct 28, 2006 at 05:01:31PM -0400, Robert P. J. Day ha scritto: 
> ok, i'm going to defer to people who are clearly much smarter about
> this than me, and i'll go back and read that entire response more
> carefully until i understand it. 

Well, if you tell me what is not clear I can try to re-explain it.

> thanks for explaining it.

No problem, the best way to learn about the kernel is reading the source
and asking questions ;)

Luca
-- 
Mi piace avere amici rispettabili;
Mi piace essere il peggiore della compagnia.
