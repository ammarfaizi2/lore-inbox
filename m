Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261878AbUKPWy0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbUKPWy0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 17:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbUKPWxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 17:53:16 -0500
Received: from linares.terra.com.br ([200.154.55.228]:39823 "EHLO
	linares.terra.com.br") by vger.kernel.org with ESMTP
	id S261876AbUKPWur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 17:50:47 -0500
X-Terra-Karma: -2%
X-Terra-Hash: a86ff98601932085a4380fb9e8f02713
Date: Tue, 16 Nov 2004 18:55:04 -0200
From: "Luiz Fernando N. Capitulino" <lcapitulino@conectiva.com.br>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, davem@davemloft.net
Subject: [PATCH 0/2] - net/socket.c simple cleanups.
Message-Id: <20041116185504.42693fea.lcapitulino@conectiva.com.br>
Organization: Conectiva S/A.
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-conectiva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hello,

 I'm sending two simple patches which cleanups
two functions in net/socket.c, they're:

[PATCH 1/2] - net/socket.c::sys_bind() cleanup.
[PATCH 2/2] - net/socket.c::__sock_create() cleanup.

 thanks
