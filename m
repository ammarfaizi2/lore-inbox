Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266203AbUFZM0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266203AbUFZM0M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 08:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266894AbUFZM0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 08:26:12 -0400
Received: from imap.gmx.net ([213.165.64.20]:18903 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266203AbUFZM0K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 08:26:10 -0400
X-Authenticated: #4512188
Message-ID: <40DD6B61.1080003@gmx.de>
Date: Sat, 26 Jun 2004 14:26:09 +0200
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040618)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.7-np1
References: <40DD4928.9090108@yahoo.com.au>
In-Reply-To: <40DD4928.9090108@yahoo.com.au>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Nick Piggin wrote:
> http://www.kerneltrap.org/~npiggin/2.6.7-np1.gz
> 
> This applies against 2.6.7-mm2 and 2.6.7-bk8 with some offsets.


it breaks a bit hfs(+) and reiser4: Somehow PageActive() seems to be 
gone...so I cannot compile.

Prakash
