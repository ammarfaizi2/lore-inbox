Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269153AbUJFNmQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269153AbUJFNmQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 09:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269173AbUJFNmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 09:42:15 -0400
Received: from mail6.hitachi.co.jp ([133.145.228.41]:3065 "EHLO
	mail6.hitachi.co.jp") by vger.kernel.org with ESMTP id S269153AbUJFNmD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 09:42:03 -0400
Message-ID: <4163F635.8000602@sdl.hitachi.co.jp>
Date: Wed, 06 Oct 2004 22:42:13 +0900
From: Hideo AOKI <aoki@sdl.hitachi.co.jp>
Organization: Systems Development Lab., Hitachi, Ltd.
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: ja
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6]  vm-thrashing-control-tuning
References: <Pine.LNX.4.44.0410050949300.30172-100000@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0410050949300.30172-100000@chimarrao.boston.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:

> While I believe that a self tuning timeout might be better in
> the long run, this tunable will certainly help tune policy.

Thank you for your comments.

I agree with you. The best solution is a self tuning timeout.
Using this swap_token_timeout parameter, I would like to get 
a clue to self tuning.


Best regards, 

Hideo AOKI

Systems Development Laboratory, Hitachi, Ltd.

