Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262496AbTEVFn0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 01:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262498AbTEVFn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 01:43:26 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:41088
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S262496AbTEVFn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 01:43:26 -0400
Date: Thu, 22 May 2003 01:46:33 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Paul Rolland <rol@as2917.net>
cc: "'Corey Minyard'" <minyard@acm.org>, "" <linux-kernel@vger.kernel.org>
Subject: Re: e100 latency, cpu cycle saver and e1000...
In-Reply-To: <019c01c32025$e4d2b9c0$3f00a8c0@witbe>
Message-ID: <Pine.LNX.4.50.0305220145340.30977-100000@montezuma.mastecende.com>
References: <019c01c32025$e4d2b9c0$3f00a8c0@witbe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 May 2003, Paul Rolland wrote:

> Of course, the problem may be completely unrelated to the NIC,
> my initial question being : is there a CPU Cycle Saver on the e1000
> as there is one on the e100... ;-)

I suppose you could call the hardware RX/TX interrupt mitigation a 'cpu 
cycle saver'

	Zwane 
-- 
function.linuxpower.ca
