Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261817AbVGEMXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbVGEMXv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 08:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261811AbVGEMXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 08:23:51 -0400
Received: from BTNL-TN-DSL-static-006.0.144.59.touchtelindia.net ([59.144.0.6]:44416
	"EHLO mail.prodmail.net") by vger.kernel.org with ESMTP
	id S261817AbVGEMQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 08:16:39 -0400
Message-ID: <42CA79DE.9060701@prodmail.net>
Date: Tue, 05 Jul 2005 17:45:26 +0530
From: RVK <rvk@prodmail.net>
Reply-To: rvk@prodmail.net
Organization: GSEC1
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Thread_Id
References: <20050723150209.GA15055@krispykreme>
In-Reply-To: <20050723150209.GA15055@krispykreme>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can anyone suggest me how to get the threadId using 2.6.x kernels. 
pthread_self() does not work and returns some -ve integer.

thanks
rvk
