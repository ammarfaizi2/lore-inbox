Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265335AbTGHU1Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 16:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265337AbTGHU1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 16:27:24 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:13491 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S265335AbTGHU0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 16:26:49 -0400
Date: Tue, 8 Jul 2003 17:38:57 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Jim Gifford <maillist@jg555.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.22-pre3
In-Reply-To: <003501c34572$4113f0c0$3400a8c0@W2RZ8L4S02>
Message-ID: <Pine.LNX.4.55L.0307081551480.21543@freak.distro.conectiva>
References: <Pine.LNX.4.55L.0307052151180.21992@freak.distro.conectiva>
 <003501c34572$4113f0c0$3400a8c0@W2RZ8L4S02>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Are you using SMP? What drivers are you using and what your workload is?

On Tue, 8 Jul 2003, Jim Gifford wrote:

> Still receiving lockups. It it is about 2 days and 10 hours before the
> system just freezes. I can use the sysrq keys to safely shutdown. No error
> messages present in any logs.
>
> As I stated in previous emails, when I run sync every hour, this prevents
> the lock ups. I will try this under the 2.4.22-pre3.
