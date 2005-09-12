Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932326AbVILWqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbVILWqS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 18:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbVILWqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 18:46:17 -0400
Received: from dvhart.com ([64.146.134.43]:60801 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S932326AbVILWqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 18:46:17 -0400
Date: Mon, 12 Sep 2005 15:46:10 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andi Kleen <ak@muc.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-mm2
Message-ID: <210290000.1126565170@flay>
In-Reply-To: <20050912185120.GA78614@muc.de>
References: <20050908053042.6e05882f.akpm@osdl.org> <201750000.1126494444@[10.10.2.4]> <20050912050122.GA3830@muc.de> <150330000.1126548402@flay> <20050912185120.GA78614@muc.de>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Monday, September 12, 2005 20:51:20 +0200 Andi Kleen <ak@muc.de> wrote:

>> Crashes on boot
>> 
>> http://test.kernel.org/12589/debug/console.log
>> 
>> May or may not be anything to do with what you were doing.
> 
> Easily tested by reverting dma32*. Does it help?

No. Yet *another* bug. Sigh.

M.

