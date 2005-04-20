Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261671AbVDTPMA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261671AbVDTPMA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 11:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261674AbVDTPL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 11:11:59 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:26763 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id S261671AbVDTPLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 11:11:52 -0400
Message-ID: <4266705E.7030502@nortel.com>
Date: Wed, 20 Apr 2005 09:08:14 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: Chris Wedgwood <cw@f00f.org>, Paul Jackson <pj@sgi.com>,
       ikebe.takashi@lab.ntt.co.jp, linux-kernel@vger.kernel.org
Subject: Re: [PATCH x86_64] Live Patching Function on 2.6.11.7
References: <4263275A.2020405@lab.ntt.co.jp> <20050418040718.GA31163@taniwha.stupidest.org> <4263356D.9080007@lab.ntt.co.jp> <20050418061221.GA32315@taniwha.stupidest.org> <42636285.9060405@lab.ntt.co.jp> <20050418075635.GB644@taniwha.stupidest.org> <20050418021609.07f6ec16.pj@sgi.com> <20050418092505.GA2206@taniwha.stupidest.org> <20050420131025.GA8255@linux-mips.org>
In-Reply-To: <20050420131025.GA8255@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ralf Baechle wrote:


> I'd try a shared library based approach for on the fly updates.

The version that I've seen imposed requirements on the application for 
this to work properly.

There are tradeoffs either way.

Chris
