Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264315AbTICVZo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 17:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264307AbTICVZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 17:25:44 -0400
Received: from chaos.analogic.com ([204.178.40.224]:6016 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264256AbTICVZm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 17:25:42 -0400
Date: Wed, 3 Sep 2003 17:25:36 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: nmi errors?
In-Reply-To: <20030903212038.GQ7353@rdlg.net>
Message-ID: <Pine.LNX.4.53.0309031724470.362@chaos>
References: <20030903212038.GQ7353@rdlg.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Sep 2003, Robert L. Harris wrote:

>
>
> Can anyone tell me what this is?
>
> 16:00:09 mailserver kernel: Uhhuh. NMI received for unknown reason 31.
> 16:00:09 mailserver kernel: Dazed and confused, but trying to continue
> 16:00:09 mailserver kernel: Do you have a strange power saving mode enabled?
> 16:00:34 mailserver kernel: Uhhuh. NMI received for unknown reason 21.
> 16:00:34 mailserver kernel: Dazed and confused, but trying to continue
>
> A coworker put a script on a server which loads up quite afew arrays
> with pre-set values and then compares the values against arrays.  As soon as he
> kicked off the script I got alot of these in my log files.  Not much longer and the
> machine crashed hard.
>

Possible bad RAM.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (794.73 BogoMips).
            Note 96.31% of all statistics are fiction.


