Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318518AbSGSOlg>; Fri, 19 Jul 2002 10:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318521AbSGSOlg>; Fri, 19 Jul 2002 10:41:36 -0400
Received: from ns1.alcove-solutions.com ([212.155.209.139]:33419 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S318518AbSGSOlg>; Fri, 19 Jul 2002 10:41:36 -0400
To: alan@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-rc2-ac2
In-Reply-To: <200207181935.g6IJZrZ06774@devserv.devel.redhat.com>
References: <200207181935.g6IJZrZ06774@devserv.devel.redhat.com>
Message-Id: <E17VYzf-0001wE-00@tahoe.alcove-fr>
From: Stelian Pop <stelian@fr.alcove.com>
Date: Fri, 19 Jul 2002 16:44:31 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In alcove.lists.linux.kernel, you wrote:
> o	Vaio C1VE/N frame buffer console mode		(Marcel Wijlaars)

Last time I've tried this patch (back in the old 2.4.5-ac series), 
it was breaking the external CRT video output (the monitor's image
was fuzzy). Maybe this was solved since then, maybe not, I shall
try it again one of these days...

Just FYI...

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
