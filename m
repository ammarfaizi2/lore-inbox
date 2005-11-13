Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbVKMJFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbVKMJFI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 04:05:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932290AbVKMJFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 04:05:07 -0500
Received: from gateway.argo.co.il ([194.90.79.130]:55565 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S932220AbVKMJFG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 04:05:06 -0500
Message-ID: <437701BD.4080002@argo.co.il>
Date: Sun, 13 Nov 2005 11:05:01 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: local denial-of-service with file leases
References: <43737CBE.2030005@argo.co.il> <20051111084554.GZ7991@shell0.pdx.osdl.net> <1131718887.8805.33.camel@lade.trondhjem.org> <20051111183512.GV5856@shell0.pdx.osdl.net> <1131737127.8793.46.camel@lade.trondhjem.org> <20051112012014.GC5856@shell0.pdx.osdl.net>
In-Reply-To: <20051112012014.GC5856@shell0.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Nov 2005 09:05:04.0331 (UTC) FILETIME=[55F861B0:01C5E831]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:

>>Sure, but I'd like a mail from Avi confirming that this patch too fixes
>>his problem, please.
>>    
>>
>
>OK, I tested with Avi's test program, and a couple other's I cobbled
>together, and they seem to work fine.  But didn't test the samba case
>(shouldn't be different...but...).
>
FWIW, I've run a short (and successful) test with samba.

Avi
