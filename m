Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275271AbTHGK46 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 06:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275276AbTHGK46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 06:56:58 -0400
Received: from excalibur.iks-jena.de ([217.17.192.67]:54197 "EHLO
	excalibur.iks-jena.de") by vger.kernel.org with ESMTP
	id S275271AbTHGK46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 06:56:58 -0400
Date: Thu, 7 Aug 2003 12:56:56 +0200
From: Erik Heinz <erik@iks-jena.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.22-rc1
Message-ID: <20030807105656.GA2003@iks-jena.de>
References: <Pine.LNX.4.44.0308051543130.12501-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308051543130.12501-100000@logos.cnet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 05, 2003 at 03:44:09PM -0300, Marcelo Tosatti wrote:
> 
> Here goes the first release candidate of 2.4.22.

I am still having problems with modular IDE. 
When trying to insmod ide-detect.o, I get:

/lib/modules/2.4.22-rc1/kernel/drivers/ide/ide-detect.o: 
  unresolved symbol ide_add_generic_settings


Thank you,
Erik

-- 
| Erik Heinz, IKS GmbH Jena * erik@iks-jena.de * privat: erik@jena.thur.de  |
+---------------------------------------------------------------------------+
