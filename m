Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261565AbULYVJr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261565AbULYVJr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 16:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbULYVJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 16:09:47 -0500
Received: from outmail1.freedom2surf.net ([194.106.33.237]:7060 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S261565AbULYVJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 16:09:46 -0500
Message-ID: <41CDD717.9020804@f2s.com>
Date: Sat, 25 Dec 2004 21:09:43 +0000
From: Ian Molton <spyro@f2s.com>
Organization: The Dragon Roost
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: domen@coderock.org
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch 2/2] delete unused file
References: <20041225171351.4D3A81F123@trashy.coderock.org>
In-Reply-To: <20041225171351.4D3A81F123@trashy.coderock.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

domen@coderock.org wrote:
> Remove nowhere referenced file. (egrep "filename\." didn't find anything)
> 
> Signed-off-by: Domen Puncer <domen@coderock.org>

Approved. This was debug code that should have gone long ago. it crept 
in when arm26 was initially created IIRC.


