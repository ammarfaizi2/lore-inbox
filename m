Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262798AbTJPIiM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 04:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262799AbTJPIiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 04:38:12 -0400
Received: from dyn-ctb-210-9-241-190.webone.com.au ([210.9.241.190]:25099 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S262798AbTJPIiJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 04:38:09 -0400
Message-ID: <3F8E58A9.20005@cyberone.com.au>
Date: Thu, 16 Oct 2003 18:36:57 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Eli Billauer <eli_billauer@users.sourceforge.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] frandom - fast random generator module
References: <3F8E552B.3010507@users.sf.net>
In-Reply-To: <3F8E552B.3010507@users.sf.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Eli Billauer wrote:

>  Hello,
>
> Frandom is the faster version of the well-known /dev/urandom random 
> number generator. Not instead of, but rather as a supplement, when 
> pseudorandom data is needed at high rate. Few tests so far show that 
> frandom is 10-50 times faster than urandom.
>

Hi

>
> Test results and comments will be appreciated.
>

Without looking at the code, why should this be done in the kernel?

