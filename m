Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263079AbUEBNSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263079AbUEBNSH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 09:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263085AbUEBNSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 09:18:07 -0400
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:37999 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263079AbUEBNSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 09:18:03 -0400
Message-ID: <4094CCF9.6070109@yahoo.com.au>
Date: Sun, 02 May 2004 20:27:05 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Pasi Savolainen <psavo@iki.fi>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3-mm1
References: <20040430014658.112a6181.akpm@osdl.org> <slrnc98gnc.cgh.psavo@varg.dyndns.org>
In-Reply-To: <slrnc98gnc.cgh.psavo@varg.dyndns.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pasi Savolainen wrote:
> * Andrew Morton <akpm@osdl.org>:
> 
>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6-rc3/2.6.6-rc3-mm1/
> 
> 
> I'm having severe interactivity problems with 2.6 tree on a dual Athlon system.
> I mostly get 'X screen freezes/mouse pointer immovable for a several
> seconds' and rather often audio skips.
> 

Make sure X is running at the normal priority (ie 0).
Does that improve things?
