Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261934AbVACXQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261934AbVACXQP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 18:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbVACXPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 18:15:55 -0500
Received: from fw.osdl.org ([65.172.181.6]:24706 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261929AbVACXPP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 18:15:15 -0500
Date: Mon, 3 Jan 2005 15:15:00 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mark_H_Johnson@raytheon.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-mm1
Message-Id: <20050103151500.3cc9afd8.akpm@osdl.org>
In-Reply-To: <OF0551C40F.E8032010-ON86256F7E.007EFEBA-86256F7E.007EFF1F@raytheon.com>
References: <OF0551C40F.E8032010-ON86256F7E.007EFEBA-86256F7E.007EFF1F@raytheon.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark_H_Johnson@raytheon.com wrote:
>
> To fix this, should I just add the EXPORT_SYMBOL lines for these symbols
>    snd_ac97_restore_status  snd_ac97_restore_iec958
>  or is something more needed?

Probably.  If that fixes it, please send the patch.
