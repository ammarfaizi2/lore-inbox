Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268294AbUIBMw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268294AbUIBMw3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 08:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268297AbUIBMw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 08:52:29 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:38578 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S268294AbUIBMv5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 08:51:57 -0400
From: Einar Lueck <elueck@de.ibm.com>
Reply-To: lkml@einar-lueck.de
Organization: IBM Deutschland Entwicklung GmbH
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] net/ipv4 for Source VIPA support, kernel BK Head
Date: Thu, 2 Sep 2004 14:51:55 +0200
User-Agent: KMail/1.6.2
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200409021401.42255.elueck@de.ibm.com> <200409021420.46785.elueck@de.ibm.com> <1094124266.4970.20.camel@localhost.localdomain>
In-Reply-To: <1094124266.4970.20.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200409021451.55318.elueck@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Donnerstag, 2. September 2004 13:24 Alan Cox wrote:
> You've failed as far as I can see to explain why NAT doesn't do the
> right thing in this case. I don't care whether the customers like it, I
> care whether it works. If it works then we don't need to add junk to the
> kernel. If it works but is hard to configure then its an opportunity to
> write a nice tool to manage it.
I am sorry: I failed to point out that NAT does the job!

We think that the the proposed patch, that is a really small one,
introduces a facility that works well for existing operating systems 
and is desired by customers. Consequently, it enriches the kernel with
a concept that has already proven its value. That's the reason why we 
think the kernel could profit from the application of the corresponding 
patch, especially as it makes more customers happy. As the whole feature 
may be configured out we don't see what's wrong with making more and 
especially large customers happy with an enriched kernel.

Einar
