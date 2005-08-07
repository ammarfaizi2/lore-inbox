Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752586AbVHGTNg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752586AbVHGTNg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 15:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752597AbVHGTNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 15:13:36 -0400
Received: from dvhart.com ([64.146.134.43]:60288 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S1752586AbVHGTNg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 15:13:36 -0400
Date: Sun, 07 Aug 2005 12:13:35 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: EXPORT_SYMBOL generates "is deprecated" noise
Message-ID: <256360000.1123442014@[10.10.2.4]>
In-Reply-To: <20050807190611.GH3513@stusta.de>
References: <251790000.1123438079@[10.10.2.4]> <20050807182312.GG3513@stusta.de> <255090000.1123440916@[10.10.2.4]> <20050807190611.GH3513@stusta.de>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> If it's going to spout crap when I'm not even using the deprecated
>> function, it's worse than useless, I'm afraid. 
>> ...
> 
> It's reminding us that we are still offering a deprecated function. ;-)

Might be useful as an option. But not to irritate every poor sod who
does a kernel compile, ever.

M.

