Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129181AbRBSW7p>; Mon, 19 Feb 2001 17:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129185AbRBSW7f>; Mon, 19 Feb 2001 17:59:35 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:10087 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129181AbRBSW70>; Mon, 19 Feb 2001 17:59:26 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200102192259.f1JMx5i31027@devserv.devel.redhat.com>
Subject: Re: [PATCH] change awe_wave initialization to match 2.2 better
To: jldomingo@crosswinds.net (José Luis Domingo López)
Date: Mon, 19 Feb 2001 17:59:05 -0500 (EST)
Cc: linux-kernel@vger.kernel.org, alan@redhat.com
In-Reply-To: <20010219222643.A2226@dardhal.mired.net> from "José Luis Domingo López" at Feb 19, 2001 10:26:43 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It seem obvious that this change in behaviour is isapnptools related, but
> not detecting the whole three IO addresses is an unresolved problem (as of
> 2.2.18, not tried with built-in PnP support in 2.4.x).

Its a bug in the hardware
