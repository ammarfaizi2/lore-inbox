Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262782AbUATKjf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 05:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265289AbUATKjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 05:39:35 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:17683 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S262782AbUATKje
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 05:39:34 -0500
Message-ID: <400D083F.6080907@aitel.hist.no>
Date: Tue, 20 Jan 2004 11:51:43 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: no, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.1-mm5 dies booting, possibly network related
References: <20040120000535.7fb8e683.akpm@osdl.org>
In-Reply-To: <20040120000535.7fb8e683.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2.6.1-mm5 didn't get very far, only about a page of bootup messages.
The last two were:

NET registered protocol family 1
NET registered protocol family 10

And then nothing.  I tried twice - sysrq+B worked the first
time, not the second.  There were no oops or other messages.
I used the new mregparm=3 option - it works for 2.6.1-mm4

Helge Hafting

