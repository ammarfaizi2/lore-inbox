Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262366AbTJAQdn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 12:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbTJAQbC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 12:31:02 -0400
Received: from intra.cyclades.com ([64.186.161.6]:51165 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262474AbTJAQ2c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 12:28:32 -0400
Date: Wed, 1 Oct 2003 13:08:30 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@dmt.cyclades
To: Xose Vazquez Perez <xose@wanadoo.es>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       syn uw <syn_uw@hotmail.com>, <linux-kernel@vger.kernel.org>,
       <marcelo.tosatti@cyclades.com.br>, <atulm@lsil.com>,
       <linux-megaraid-devel@dell.com>
Subject: Re: Megaraid does not work with 2.4.22
In-Reply-To: <3F7AF183.5050900@wanadoo.es>
Message-ID: <Pine.LNX.4.44.0310011307300.3451-100000@dmt.cyclades>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 1 Oct 2003, Xose Vazquez Perez wrote:

> Marcelo Tosatti wrote:
> 
> > Having two drivers for the same controller is not a good thing from a user
> 
> this doesn't is first time:
> e100/eepro100 aic7xxx/aic7xxx_old  sym53c8xx_2/sym53c8xx+ncr53c8xx ...

Yes its not but still, it sucks.

> > point of view. I just asked Atul privately but will do so again here: Why
> > do we need "megaraid2" ?
> 
> megaraid 1.xx gets *very bad* performance. But like 2.4 is stable serie, it
> shouldn't be deleted.
> 
> megaraid 2.xx gets correct performance, it's stable and it adds support
> for _present_ hardware, MegaRAID Ultra320 RAID boards(518, 520, 531, 532).

Fine. I agree on adding in to mainline 2.4.x. 


