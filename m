Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752745AbWKQTHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752745AbWKQTHT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 14:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755707AbWKQTHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 14:07:18 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:14305 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1752745AbWKQTHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 14:07:17 -0500
Subject: Re: 2.6.19-rc6-rt0, -rt YUM repository
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Daniel Walker <dwalker@mvista.com>,
       Esben Nielsen <nielsen.esben@googlemail.com>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <20061117161742.GA10182@elte.hu>
References: <20061116153553.GA12583@elte.hu>
	 <1163694712.26026.1.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0611162212110.21141@frodo.shire>
	 <1163713469.26026.4.camel@localhost.localdomain>
	 <20061116220733.GA17217@elte.hu> <1163779116.6953.38.camel@mindpipe>
	 <20061117161742.GA10182@elte.hu>
Content-Type: text/plain
Date: Fri, 17 Nov 2006 13:45:44 -0500
Message-Id: <1163789144.6953.57.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-17 at 17:17 +0100, Ingo Molnar wrote:
> thanks, please do that. Right now i have no open boot-crash regression 
> left that i can reproduce.

Possibly old news, but with 2.6.18-rt7 this user gets an Oops in
read_hpet() if high res timers are enabled.

http://ubuntuforums.org/showthread.php?t=292071

Lee

