Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264944AbTF0XxK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 19:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264952AbTF0XxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 19:53:10 -0400
Received: from windsormachine.com ([206.48.122.28]:12817 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id S264944AbTF0XxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 19:53:07 -0400
Date: Fri, 27 Jun 2003 20:07:20 -0400 (EDT)
From: Mike Dresser <mdresser_l@windsormachine.com>
To: Larry McVoy <lm@bitmover.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bkbits.net is down
In-Reply-To: <Pine.LNX.4.33.0306271959190.12141-100000@router.windsormachine.com>
Message-ID: <Pine.LNX.4.33.0306272005260.12141-100000@router.windsormachine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jun 2003, Mike Dresser wrote:

> > DAC960#0: Physical Device 0:0 Request Sense: Sense Key = 3, ASC = 11, ASCQ = 00
>
> 0Bh 01h DTLPWRSOMCAE Warning - specified temperature exceeded

Hum, why did i convert decimal to hex?

http://www.t10.org/lists/asc-num.htm#ASC_03

device write fault.

Bad sectors on that drive?

Which could still be related to the heat ;)

Mike

