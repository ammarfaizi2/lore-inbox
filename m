Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261567AbULYVMD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbULYVMD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 16:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbULYVMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 16:12:03 -0500
Received: from outmail1.freedom2surf.net ([194.106.33.237]:33684 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S261567AbULYVL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 16:11:59 -0500
Message-ID: <41CDD79B.9060908@f2s.com>
Date: Sat, 25 Dec 2004 21:11:55 +0000
From: Ian Molton <spyro@f2s.com>
Organization: The Dragon Roost
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: domen@coderock.org
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch 1/2] delete unused file
References: <20041225171348.5BA3B1EA0F@trashy.coderock.org>
In-Reply-To: <20041225171348.5BA3B1EA0F@trashy.coderock.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Molton wrote:
 > domen@coderock.org wrote:
 >
 >> Remove nowhere referenced file. (egrep "filename\." didn't find 
anything)
 >>
 >> Signed-off-by: Domen Puncer <domen@coderock.org>
 >
 >
 > Nice catch. This is also no longer wanted in arm26. Approved and 
applied locally.
