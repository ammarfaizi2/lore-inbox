Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932207AbWC1LeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbWC1LeT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 06:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbWC1LeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 06:34:19 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:24756 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932207AbWC1LeS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 06:34:18 -0500
Subject: Re: OOM kills if swappiness set to 0, swap storms otherwise
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1143510828.1792.353.camel@mindpipe>
References: <1143510828.1792.353.camel@mindpipe>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 28 Mar 2006 12:41:50 +0100
Message-Id: <1143546110.17522.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-03-27 at 20:53 -0500, Lee Revell wrote:
> What is the problem here?  Is the modern Linux desktop really too
> bloated to run in half a gig of RAM, or is the kernel overzealous with
> its OOM killing?

Evolution will regularly try and eat over 1GByte of RAM. In addition it
is possible for an attacker to send you a plain text email that makes it
do this.

If you want to run gnome & firefox & evolution you need a lot more RAM.
Alternatively run something sane and sensible.

Alan
(whose todo list does indeed have 'new mailer' on it)

