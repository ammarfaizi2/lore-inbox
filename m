Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261248AbULWP1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbULWP1j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 10:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbULWP1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 10:27:39 -0500
Received: from static64-74.dsl-blr.eth.net ([61.11.64.74]:9990 "EHLO
	linmail.globaledgesoft.com") by vger.kernel.org with ESMTP
	id S261248AbULWP1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 10:27:38 -0500
Message-ID: <41CAE29C.3090301@globaledgesoft.com>
Date: Thu, 23 Dec 2004 20:52:04 +0530
From: krishna <krishna.c@globaledgesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dick Streefland <dick.streefland@altium.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: Significance of  variable arguments
References: <41CABBF1.6050304@globaledgesoft.com> <78e9.41cadbfa.a0385@altium.nl>
In-Reply-To: <78e9.41cadbfa.a0385@altium.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you very much.

Dick Streefland wrote:

>krishna <krishna.c@globaledgesoft.com> wrote:
>| Can any one tell me a source which explains the significance of variable 
>| arguments.
>| 
>| eg : struct task_struct *kthread_create(int (*threadfn)(void *data),
>|                                    void *data,
>|                                    const char namefmt[],
>|                                    ...)
>
>man stdarg
>
>  
>
