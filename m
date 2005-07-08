Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262248AbVGHDus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262248AbVGHDus (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 23:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262537AbVGHDus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 23:50:48 -0400
Received: from mail21.syd.optusnet.com.au ([211.29.133.158]:19379 "EHLO
	mail21.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262248AbVGHDuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 23:50:46 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Rudo Thomas <rudo@matfyz.cz>
Subject: Re: 2.6.12-ck3
Date: Fri, 8 Jul 2005 13:52:55 +1000
User-Agent: KMail/1.8.1
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck list <ck@vds.kolivas.org>
References: <200506301241.00593.kernel@kolivas.org> <20050704091648.GA14759@ss1000.ms.mff.cuni.cz> <20050707213034.GA9306@ss1000.ms.mff.cuni.cz>
In-Reply-To: <20050707213034.GA9306@ss1000.ms.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507081352.55660.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jul 2005 07:30 am, Rudo Thomas wrote:
> Hi again.
>
> > Time seems to pass very fast with this kernel.
>
> dmesg output has not revealed anything extraordinary...
>
> Am I the only one who gets this strange behaviour? Kernel's notion of
> time seems to be about 30 times faster than real time.
>
> I will gladly provide any information that will help sorting this
> problem out.

Sorry I really have no idea. If you can retest with latest stable mainline 
that this kernel is based on (2.6.12.2) and reproduce the problem, then 
posting that info along with a summary of your 'lspci -vv' and 'dmesg' 
and .config might be helpful as out-of-kernel patchsets are often ignored by 
most developers apart from the maintainer (ie me in this case.)

Cheers,
Con
