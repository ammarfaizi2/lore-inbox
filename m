Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264386AbUGSXHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264386AbUGSXHQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 19:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264638AbUGSXHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 19:07:16 -0400
Received: from relay.pair.com ([209.68.1.20]:22289 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S264386AbUGSXHP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 19:07:15 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <40FC3CAC.2070206@kegel.com>
Date: Mon, 19 Jul 2004 14:27:08 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en, de-de
MIME-Version: 1.0
To: solt@dns.toxicfilms.tv,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: re: [partially solved] tcp_window_scaling degrades performance
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej Soltysiak <solt@dns.toxicfilms.tv> wrote:
> It appears that checkpoint fw-1 that is here spoils everything so that
> current linux boxes need to disable tcp_windows_scaling to get
> reasonable throughput.

Just checking- have you read
http://lwn.net/Articles/91976/
("TCP window scaling and broken routers")?

- Dan

-- 
My technical stuff: http://kegel.com
My politics: see http://www.misleader.org for examples of why I'm for regime change
