Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265041AbTFLWrA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 18:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265043AbTFLWq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 18:46:59 -0400
Received: from wmail.atlantic.net ([209.208.0.84]:28856 "HELO
	wmail.atlantic.net") by vger.kernel.org with SMTP id S265041AbTFLWq4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 18:46:56 -0400
Message-ID: <3EE90933.8090209@techsource.com>
Date: Thu, 12 Jun 2003 19:13:55 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Schwartz <davids@webmaster.com>
CC: Muthian Sivathanu <muthian_s@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: limit resident memory size
References: <MDEHLPKNGKAHNMBLJOLKOEBMDKAA.davids@webmaster.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



David Schwartz wrote:
>>I would like to limit the maximum resident memory size
>>of a process within a threshold, i.e. if its virtual
>>memory footprint exceeds this threshold, it needs to
>>swap out pages *only* from within its VM space.
> 
> 
> 	Why? If you think this is a good way to be nice to other processes, you're
> wrong.

Why is he wrong?


