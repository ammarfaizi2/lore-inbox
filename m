Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261619AbUKOPSd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbUKOPSd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 10:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbUKOPRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 10:17:40 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:21986 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261619AbUKOPRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 10:17:03 -0500
Subject: Re: source address for UDP broadcasts with aliased interfaces?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Daniel Risacher <magnus@alum.mit.edu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <87lld6n3ep.fsf@m5.risacher.org>
References: <87lld6n3ep.fsf@m5.risacher.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1100528031.27202.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 15 Nov 2004 14:13:52 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-11-12 at 21:49, Daniel Risacher wrote:
> I'm not sure if this is a bug or a feature.

Assuming the address provided is valid I would say bug. You should
however post that query to netdev@oss.sgi.com - that is the networking
list and has a lot more people on it who deal with the network layer

