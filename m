Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264034AbUFFXps@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264034AbUFFXps (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 19:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264228AbUFFXps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 19:45:48 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:12186 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S264226AbUFFXpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 19:45:47 -0400
Message-ID: <40C3AD9E.9070909@elegant-software.com>
Date: Sun, 06 Jun 2004 19:49:50 -0400
From: Russell Leighton <russ@elegant-software.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: arjanv@redhat.com
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Using getpid() often, another way? [was Re: clone() <->	getpid()
 bug in 2.6?]
References: <40C1E6A9.3010307@elegant-software.com>	 <Pine.LNX.4.58.0406051341340.7010@ppc970.osdl.org>	 <40C32A44.6050101@elegant-software.com>	 <40C33A84.4060405@elegant-software.com> <1086537490.3041.2.camel@laptop.fenrus.com>
In-Reply-To: <1086537490.3041.2.camel@laptop.fenrus.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

> Note also that
>
>clone() is not a portable interface even within linux architectures.
>
>  
>
Really???!!! How so?
