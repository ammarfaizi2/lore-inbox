Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264339AbUBII3N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 03:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264428AbUBII3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 03:29:13 -0500
Received: from gw-nl5.philips.com ([161.85.127.51]:38017 "EHLO
	gw-nl5.philips.com") by vger.kernel.org with ESMTP id S264339AbUBII3K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 03:29:10 -0500
Message-ID: <40274581.4030002@basmevissen.nl>
Date: Mon, 09 Feb 2004 09:32:01 +0100
From: Bas Mevissen <ml@basmevissen.nl>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kyle <kyle@southa.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ICH5 with 2.6.1 very slow
References: <164601c3ec06$be8bd5a0$b8560a3d@kyle> <40227C20.80404@basmevissen.nl> <167301c3ec0d$4d8508c0$b8560a3d@kyle> <40227D9D.2070704@basmevissen.nl> <168301c3ec0e$24698be0$b8560a3d@kyle> <4023682E.3060809@basmevissen.nl> <001101c3ecf8$b0f50cc0$b8560a3d@kyle>
In-Reply-To: <001101c3ecf8$b0f50cc0$b8560a3d@kyle>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle wrote:

> Today I tried 

(...)

This is quite strange. The only thing I can think of is that the 
hardware (?) raid1 is causing problems with 2.6.

Is there a possibility for you to test without it?

Currently, I don't have a decent PATA disk luyng around, so I cannot 
verify anything for you.

Regards,

Bas.


