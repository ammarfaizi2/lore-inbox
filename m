Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbUDJQ70 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 12:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbUDJQ70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 12:59:26 -0400
Received: from ns.clanhk.org ([69.93.101.154]:43187 "EHLO mail.clanhk.org")
	by vger.kernel.org with ESMTP id S262063AbUDJQ70 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 12:59:26 -0400
Message-ID: <4078280B.5080604@clanhk.org>
Date: Sat, 10 Apr 2004 11:59:55 -0500
From: "J. Ryan Earl" <heretic@clanhk.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mohamed Aslan <mkernel@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Rewrite Kernel
References: <20040407125406.209FC39834A@ws5-1.us4.outblaze.com>
In-Reply-To: <20040407125406.209FC39834A@ws5-1.us4.outblaze.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mohamed Aslan wrote:

>i wanna to rewrite a version of linux kernel from scratch in assembly for intel 386+ fo speed and a libc also in assembly for speed
>what do u think guys
>  
>
I doubt you would be capable of generating assembly that would be any 
faster than gcc, and you would inherit all the accidental difficulties 
that come with engineering software at a lower-level.

-ryan
