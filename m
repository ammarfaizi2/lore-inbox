Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262582AbUCEMsn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 07:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262581AbUCEMsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 07:48:43 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:8928 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262583AbUCEMrX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 07:47:23 -0500
Date: Fri, 5 Mar 2004 13:47:18 +0100
From: Jens Axboe <axboe@suse.de>
To: "Jinu M." <jinum@esntechnologies.co.in>
Cc: linux-kernel@vger.kernel.org
Subject: Re: INIT_REQUEST & CURRENT undeclared!
Message-ID: <20040305124718.GQ10923@suse.de>
References: <1118873EE1755348B4812EA29C55A9721286F8@esnmail.esntechnologies.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118873EE1755348B4812EA29C55A9721286F8@esnmail.esntechnologies.co.in>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05 2004, Jinu M. wrote:
> Alright I get it ;)
> 
> MAJOR_NR should be defined before including the header files.

You probably want to rewrite that anyways, you are basing your driver on
2.0 linux block driver design...

> What was that Kernel 7.9.13 hmm... :p (thanks anyways ch.12 did help!)

Just a reference to the fact that you didn't even state what kernel
version you were using.

-- 
Jens Axboe

