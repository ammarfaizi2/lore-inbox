Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262350AbVAZQU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262350AbVAZQU2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 11:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262347AbVAZQSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 11:18:48 -0500
Received: from gizmo11ps.bigpond.com ([144.140.71.21]:38310 "HELO
	gizmo11ps.bigpond.com") by vger.kernel.org with SMTP
	id S262350AbVAZQS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 11:18:27 -0500
Message-ID: <41F7C2CA.2080107@bigpond.net.au>
Date: Thu, 27 Jan 2005 03:18:18 +1100
From: Cal <hihone@bigpond.net.au>
Reply-To: hihone@bigpond.net.au
User-Agent: Mozilla Thunderbird 0.6+ (X11/20050122)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: linux <linux-kernel@vger.kernel.org>, CK Kernel <ck@vds.kolivas.org>,
       "Jack O'Quin" <joq@io.com>
Subject: Re: [ck] [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU feature, -D7
References: <87y8eo9hed.fsf@sulphur.joq.us> <20050120172506.GA20295@elte.hu>	<87wtu6fho8.fsf@sulphur.joq.us> <20050122165458.GA14426@elte.hu>	<87hdl940ph.fsf@sulphur.joq.us> <20050124085902.GA8059@elte.hu>	<20050124125814.GA31471@elte.hu> <20050125135613.GA18650@elte.hu>	<41F6C5CE.9050303@bigpond.net.au> <41F6C797.80403@bigpond.net.au> <20050126100846.GB8720@elte.hu>
In-Reply-To: <20050126100846.GB8720@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=0.93.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> [...] the -D7 patch available from the usual place:

Hi,

Consideringthe amount and rate of work in progress, this may well be no 
longer be pertinent, but I'm consistently getting an oops running the 
basic jack_test3.2 with rt-limit-2.6.11-rc2-D7 on SMP (P3 993 x 2). The 
oops and jacktest log are at
  <http://www.graggrag.com/20050127-oops/>.

cheers, Cal

