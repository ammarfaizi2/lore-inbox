Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261313AbUKBXLx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbUKBXLx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 18:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbUKBXGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 18:06:38 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:37822 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262343AbUKBXBi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 18:01:38 -0500
Message-ID: <4188118A.5050300@us.ibm.com>
Date: Tue, 02 Nov 2004 15:00:26 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Andrea Arcangeli <andrea@novell.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: fix iounmap and a pageattr memleak (x86 and x86-64)
References: <4187FA6D.3070604@us.ibm.com> <20041102220720.GV3571@dualathlon.random> <41880E0A.3000805@us.ibm.com>
In-Reply-To: <41880E0A.3000805@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BTW, please don't anyone going even trying to apply that piece of crap I 
just sent out, I just wanted to demonstrate what solves my immediate 
problem.
