Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbVF1Jyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbVF1Jyr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 05:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262036AbVF1Jyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 05:54:47 -0400
Received: from fest.stud.feec.vutbr.cz ([147.229.72.16]:44256 "EHLO
	fest.stud.feec.vutbr.cz") by vger.kernel.org with ESMTP
	id S262097AbVF1Jyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 05:54:46 -0400
Message-ID: <42C11E61.4050209@stud.feec.vutbr.cz>
Date: Tue, 28 Jun 2005 11:54:41 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Al Boldi <a1426z@gawab.com>
CC: "'Marcelo Tosatti'" <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Kswapd flaw
References: <200506280908.MAA13504@raad.intranet>
In-Reply-To: <200506280908.MAA13504@raad.intranet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Boldi wrote:
> Michal Schmidt wrote:
>>If you don't like this, call mlockall() in your program.
> 
> 
> Thanks for the pointer, but what if I don't own the source.

An LD_PRELOAD trick might work.

Michal
