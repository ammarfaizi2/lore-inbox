Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932392AbVISNrV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbVISNrV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 09:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbVISNrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 09:47:21 -0400
Received: from thorn.pobox.com ([208.210.124.75]:45978 "EHLO thorn.pobox.com")
	by vger.kernel.org with ESMTP id S932392AbVISNrU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 09:47:20 -0400
Message-ID: <432EC15F.3050203@rtr.ca>
Date: Mon, 19 Sep 2005 09:47:11 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050728
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Grzegorz Piotr Jaskiewicz <gj@kdemail.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: dell's latitude cdburner problem
References: <200509182257.23363@gj-laptop>
In-Reply-To: <200509182257.23363@gj-laptop>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grzegorz Piotr Jaskiewicz wrote:
>
> I have dell latitude c640 laptop with their's dvd/cd-rw combo drive that 
..
> Trouble is, that this drive suppose to write CDs at 24x, and does so under 
> windows. But under Linux it works only 8x. Anyone with the same problem 

If it's the NEC burner that Dell currently ships, then those drives are
very fussy about CD-R blank media.  Name-brand Maxell and others burn
at full speed, but most of the no-name discs I have here are locked
to 16X or slower.

-ml
