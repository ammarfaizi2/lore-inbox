Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268415AbUHQUn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268415AbUHQUn7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 16:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266705AbUHQUn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 16:43:59 -0400
Received: from postman.fhs-hagenberg.ac.at ([193.170.124.96]:61190 "EHLO
	postman.fhs-hagenberg.ac.at") by vger.kernel.org with ESMTP
	id S268415AbUHQUn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 16:43:28 -0400
Message-ID: <41226CFB.9050905@fh-hagenberg.at>
Date: Tue, 17 Aug 2004 22:39:23 +0200
From: Manuel Lauss <manuel.lauss@fh-hagenberg.at>
Organization: FH Hagenberg / HSSE
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040808)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: maneesh@in.ibm.com
CC: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Fw: 2.6.8.1-mm1: oops with firmware loading
References: <20040817110533.036abf8f.akpm@osdl.org> <20040817194950.GA1536@in.ibm.com>
In-Reply-To: <20040817194950.GA1536@in.ibm.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Aug 2004 20:36:45.0793 (UTC) FILETIME=[E9A42D10:01C48499]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maneesh Soni wrote:

[...]

> My fault, a bad typo in fs/sysfs/bin.c.
> 
> Manuel, can you try this change in fs/sysfs/bin.c

<patch snipped>

yup, works, thanks!

-- 
Manuel Lauss
Student HSSE / FH Hagenberg
