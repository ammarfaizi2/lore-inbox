Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262383AbUKRCcz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262383AbUKRCcz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 21:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262397AbUKRCcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 21:32:54 -0500
Received: from smtp806.mail.sc5.yahoo.com ([66.163.168.185]:55683 "HELO
	smtp806.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262383AbUKRCcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 21:32:43 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Trivial update: option for default ondemand cpufreq governor
Date: Wed, 17 Nov 2004 21:32:38 -0500
User-Agent: KMail/1.6.2
Cc: Pedro Venda <pjlv@mega.ist.utl.pt>, davej@codemonkey.org.uk
References: <419BF015.3050900@mega.ist.utl.pt>
In-Reply-To: <419BF015.3050900@mega.ist.utl.pt>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200411172132.39274.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday 17 November 2004 07:43 pm, Pedro Venda wrote:
> This is a trivial patch that adds a Kconfig option to select the
> *ondemand* cpufreq governor as the *default cpufreq governor*.
> 

See here:

	http://www.ussg.iu.edu/hypermail/linux/kernel/0408.3/0953.html

"... If transition_latency is high, the ondemand governor initialization
will fail (User level governor is suggested in this case). Hence it cannot
be used as a default governor." 

-- 
Dmitry
