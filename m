Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271926AbRHVGpR>; Wed, 22 Aug 2001 02:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271949AbRHVGo6>; Wed, 22 Aug 2001 02:44:58 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:47547 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S271926AbRHVGop>; Wed, 22 Aug 2001 02:44:45 -0400
From: Christoph Rohland <cr@sap.com>
To: andersen@codepoet.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] sysinfo compatibility
In-Reply-To: <Pine.LNX.4.21.0108211137340.1320-100000@localhost.localdomain>
	<m34rr12ueb.fsf@linux.local> <20010821114640.A25151@codepoet.org>
Organisation: SAP LinuxLab
Date: 22 Aug 2001 08:44:39 +0200
In-Reply-To: <20010821114640.A25151@codepoet.org>
Message-ID: <m3bsl81tm0.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Erik,

On Tue, 21 Aug 2001, Erik Andersen wrote:
> Its your lucky day.  Put something like this in your installer,
> and your problems will go away:

We fixed the installer for our upcoming release. But we cannot change
the CDs which were assembled and delivered some time ago. And yes, I
know how to use LD_PRELOAD...

BTW I appreciate the basics of the change for 2.4, but I don't agree
that we should break cases which worked before. (And the comment in
the sources is plain wrong that 2.2 failed in these cases)

Greetings
		Christoph


