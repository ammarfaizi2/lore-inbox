Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318314AbSGRSlc>; Thu, 18 Jul 2002 14:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318315AbSGRSlc>; Thu, 18 Jul 2002 14:41:32 -0400
Received: from codepoet.org ([166.70.99.138]:16279 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S318314AbSGRSlb>;
	Thu, 18 Jul 2002 14:41:31 -0400
Date: Thu, 18 Jul 2002 12:44:32 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Rudmer van Dijk <rvandijk@science.uva.nl>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-rc2-ac1
Message-ID: <20020718184432.GA9911@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Rudmer van Dijk <rvandijk@science.uva.nl>,
	Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
References: <200207181545.g6IFjgG24953@devserv.devel.redhat.com> <20020718181213Z318284-686+2229@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020718181213Z318284-686+2229@vger.kernel.org>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Jul 18, 2002 at 08:19:59PM +0200, Rudmer van Dijk wrote:
> build ok, but panics at boot.

Same here -- crashed while starting up the ide subsystem. 
I didn't have a serial console hooked up, so I don't have 
the oops,

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
