Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268805AbUHUBRj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268805AbUHUBRj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 21:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268807AbUHUBRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 21:17:39 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:24443 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268805AbUHUBRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 21:17:38 -0400
Message-ID: <4126A2A6.1020403@yahoo.com.au>
Date: Sat, 21 Aug 2004 11:17:26 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: Simon Derr <Simon.Derr@bull.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CPU stuck in wake_up_forked_thread()
References: <Pine.A41.4.53.0408201742100.20680@isabelle.frec.bull.fr>
In-Reply-To: <Pine.A41.4.53.0408201742100.20680@isabelle.frec.bull.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon Derr wrote:
> Hi,
> 
> It seems (as of 2.6.8-rc3) that there is an issue in
> wake_up_forked_thread():
> 

Should be fixed in the -mm tree, which should be merged up
soon.
