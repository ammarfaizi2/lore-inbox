Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271563AbTGQSb6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 14:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271584AbTGQS2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 14:28:16 -0400
Received: from web20006.mail.yahoo.com ([216.136.225.69]:57643 "HELO
	web20006.mail.yahoo.com") by vger.kernel.org with SMTP
	id S271563AbTGQSZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 14:25:05 -0400
Message-ID: <20030717183958.74004.qmail@web20006.mail.yahoo.com>
Date: Thu, 17 Jul 2003 11:39:58 -0700 (PDT)
From: navneet panda <navneet_panda@yahoo.com>
Subject: Re: kernel panic at boot
To: William T Wilson <fluffy@snurgle.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0307171405460.18906-100000@benatar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for the suggestion but I already tried that
with

root=/dev/hda6 ( same as for working 2.4.20-18 )

It didn't work

Thanks anyway
Panda

--- William T Wilson <fluffy@snurgle.org> wrote:
> On Thu, 17 Jul 2003, navneet panda wrote:
> 
> > root=LABEL=/ hdc=ide-scsi idebus=66
> 
> Try gettin rid of worthless LABEL= and use a device
> identifier (i.e.  
> root=/dev/hda3 or whatever).  I have found that
> LABEL= is uniformly more
> trouble than it is worth.
> 


__________________________________
Do you Yahoo!?
SBC Yahoo! DSL - Now only $29.95 per month!
http://sbc.yahoo.com
