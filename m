Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262186AbTJYBDb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 21:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262197AbTJYBDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 21:03:31 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:8721 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S262186AbTJYBDa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 21:03:30 -0400
Message-Id: <200310250108.h9P18paK003981@ccure.karaya.com>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Brice Goglin <Brice.Goglin@ens-lyon.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: uml-patch-2.6.0-test8 
In-Reply-To: Your message of "Wed, 22 Oct 2003 10:37:42 +0200."
             <20031022083742.GR8782@ens-lyon.fr> 
References: <20031022083742.GR8782@ens-lyon.fr> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 24 Oct 2003 21:08:51 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brice.Goglin@ens-lyon.fr said:
> Hi Jeff,
> Your last UML patch for 2.6.0-test8 looks fine for me, except when
> enabling loadable module support (CONFIG_MODULES). 

Known problem, I haven't got around to implementing the changes needed
for modules in 2.6.

				Jeff

