Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261792AbUKPUTa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261792AbUKPUTa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 15:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbUKPUTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 15:19:01 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:40679 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261792AbUKPUP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 15:15:28 -0500
Subject: Re: Slab corruption with 2.6.9 + swsusp2.1
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Ake <Ake.Sandgren@hpc2n.umu.se>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041116115917.GN4344@hpc2n.umu.se>
References: <20041116115917.GN4344@hpc2n.umu.se>
Content-Type: text/plain
Message-Id: <1100635759.4362.4.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 17 Nov 2004 07:09:19 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2004-11-16 at 22:59, Ake wrote:
> I got a slab corruption message running 2.6.9 + swsusp2.1 and
> nvidia_compat.patch + vm-pages_scanned-active_list.patch from -ck3.

Just so I'm clear, why do you think it's suspending that's causing the
corruption?

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

