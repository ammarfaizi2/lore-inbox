Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272357AbTHINsJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 09:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272358AbTHINsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 09:48:09 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:58117 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S272357AbTHINsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 09:48:07 -0400
Subject: Re: 2.6.0-test3 cannot mount root fs
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Norbert Preining <preining@logic.at>
Cc: gaxt <gaxt@rogers.com>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030809104024.GA12316@gamma.logic.tuwien.ac.at>
References: <3F34D0EA.8040006@rogers.com>
	 <20030809104024.GA12316@gamma.logic.tuwien.ac.at>
Content-Type: text/plain
Message-Id: <1060436885.467.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sat, 09 Aug 2003 15:48:05 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-08-09 at 12:40, Norbert Preining wrote:
> On Sam, 09 Aug 2003, gaxt wrote:
> > Try changing in your bootloader root=/dev/hdb1 to root=341

Justa stupid guess, but the format has been changed. Instead, try

root=03:41

