Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261298AbULMR4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbULMR4r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 12:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbULMR4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 12:56:47 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:44228 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261298AbULMR4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 12:56:38 -0500
Message-ID: <41BDD7CA.1020806@sgi.com>
Date: Mon, 13 Dec 2004 11:56:26 -0600
From: Eric Sandeen <sandeen@sgi.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Eric Sandeen <sandeen@sgi.com>
CC: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>,
       Patrick <nawtyness@gmail.com>, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com,
       "Kristofer T. Karas" <ktk@enterprise.bidmc.harvard.edu>
Subject: Re: Unknown Issue.
References: <2E314DE03538984BA5634F12115B3A4E01BC4179@email1.mitretek.org> <41BDD659.9070500@sgi.com>
In-Reply-To: <41BDD659.9070500@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Sandeen wrote:

>> Dec  5 08:23:53 jpiszcz kernel: XFS internal error
>> XFS_WANT_CORRUPTED_GOTO at line 1583 of file fs/xfs/xfs_alloc.c.  Caller
>> 0xc021de57
> 
> (having trouble replaying the log here)
> 
> Ok, so XVM has found something wrong at this point.  

urk, make that "XFS has found..." of course :)

-Eric
