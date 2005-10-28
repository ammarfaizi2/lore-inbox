Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbVJ1XYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbVJ1XYQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 19:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbVJ1XYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 19:24:16 -0400
Received: from sccrmhc11.comcast.net ([63.240.77.81]:31987 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1750730AbVJ1XYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 19:24:16 -0400
In-Reply-To: <1130540164.29054.130.camel@gaston>
References: <15DF6933-2475-439D-BE0A-DC232B92FDB7@comcast.net> <1130540164.29054.130.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <05700451-DD42-4BBE-9DB2-8705B88548BF@comcast.net>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Parag Warudkar <kernel-stuff@comcast.net>
Subject: Re: PPC32 - No IDE/ATA devices on new PowerBook
Date: Fri, 28 Oct 2005 19:24:13 -0400
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Oct 28, 2005, at 6:56 PM, Benjamin Herrenschmidt wrote:

>
> Not yet, I haven't had the machine I ordered yet so I haven't yet  
> had a
> chance to investigate/fix the problem. I suppose it's mostly a  
> matter of
> adding a new PCI ID to drivers/ide/ppc/pmac.c though.
>
> Ben.

Thanks. I tried 2.4 kernel and to my surprise it detected the IDE/ATA  
controller! (Although it balked out with errors - read past the end  
of the device or something...).

Parag
