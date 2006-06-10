Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932352AbWFJAeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbWFJAeo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 20:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932609AbWFJAeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 20:34:44 -0400
Received: from gate.crashing.org ([63.228.1.57]:39089 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932352AbWFJAeo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 20:34:44 -0400
Subject: Re: RFC: dma_mmap_coherent() for powerpc/ppc architecture and ALSA?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060608205048.113800@gmx.net>
References: <20060608205048.113800@gmx.net>
Content-Type: text/plain
Date: Sat, 10 Jun 2006 10:34:25 +1000
Message-Id: <1149899665.12687.95.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This leads me to the question, if there are any plans to include the dma_mmap_coherent() function (for powerpc/ppc and/or any other platform) in one of the next kernel versions and if an adapation of the ALSA drivers is planned. Or is there a simple way (hack) to fix this problem?

You are welcome to do a patch implementing this :)

Ben.


