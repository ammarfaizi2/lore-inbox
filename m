Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261716AbVGUJhp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261716AbVGUJhp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 05:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbVGUJhp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 05:37:45 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:57733 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261716AbVGUJhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 05:37:37 -0400
Message-ID: <42DF6CC5.5070209@gmail.com>
Date: Thu, 21 Jul 2005 11:37:09 +0200
From: Jiri Slaby <lnx4us@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Greg Ungerer <gerg@snapgear.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Obsolete files in 2.6 tree
References: <42DF2A6B.9050501@snapgear.com>
In-Reply-To: <42DF2A6B.9050501@snapgear.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Ungerer napsal(a):

> Jiri Slaby wrote:
>
>> fs/binfmt_flat.c
>
>
> This is not obsolate, it is used by most MMUless architectures
> as the primary executable file loader.
>
> It compiles (and works).

You are all right, I am going to control the list again.
