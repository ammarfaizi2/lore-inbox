Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262039AbVCaWpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262039AbVCaWpa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 17:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbVCaWpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 17:45:30 -0500
Received: from fire.osdl.org ([65.172.181.4]:39813 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262039AbVCaWp0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 17:45:26 -0500
Date: Thu, 31 Mar 2005 14:44:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, johnpol@2ka.mipt.ru,
       jlan@engr.sgi.com, efocht@hpce.nec.com, linuxram@us.ibm.com,
       gh@us.ibm.com, elsa-devel@lists.sourceforge.net, aquynh@gmail.com,
       dean-list-linux-kernel@arctic.org, pj@sgi.com
Subject: Re: [patch 2.6.12-rc1-mm4] fork_connector: add a fork connector
Message-Id: <20050331144428.7bbb4b32.akpm@osdl.org>
In-Reply-To: <1112277542.20919.215.camel@frecb000711.frec.bull.fr>
References: <1112277542.20919.215.camel@frecb000711.frec.bull.fr>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guillaume Thouvenin <guillaume.thouvenin@bull.net> wrote:
>
>   This patch adds a fork connector in the do_fork() routine.
> ...
>
>   The fork connector is used by the Enhanced Linux System Accounting
> project http://elsa.sourceforge.net

Does it also meet all the in-kernel requirements for other accounting
projects?

If not, what else do those other projects need?
