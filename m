Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261391AbUKINws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261391AbUKINws (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 08:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261403AbUKINws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 08:52:48 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:39095 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S261391AbUKINwq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 08:52:46 -0500
From: Alistair John Strachan <alistair@devzero.co.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Kernel or failing harddisc?
Date: Tue, 9 Nov 2004 13:50:15 +0000
User-Agent: KMail/1.7.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200411090054.48164.alistair@devzero.co.uk> <1099998443.15469.17.camel@localhost.localdomain>
In-Reply-To: <1099998443.15469.17.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411091350.15626.alistair@devzero.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 Nov 2004 11:07, Alan Cox wrote:
[snip]
>
> It could be anything. An interrupt went walkies which could easily be
> the driver, thermals, cabling, phase of the moon, drive,... If those are
> the only logged lines then the drive hasn't reported any problems back.
>
> Failed maxtors normally make it very clear they died - both in smart
> data (usually) and by spewing drive level errors.
>
> Alan

Thanks Alan, I'll look into it. Since I've not received any SMART warnings, 
I'll just assume the drive is fine and it's something else.

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/AI Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.
