Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266705AbUJBO4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266705AbUJBO4k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 10:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266721AbUJBO4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 10:56:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18654 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266705AbUJBO4i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 10:56:38 -0400
Date: Sat, 2 Oct 2004 10:56:16 -0400
From: Alan Cox <alan@redhat.com>
To: Olaf Hering <olh@suse.de>
Cc: Alan Cox <alan@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: missing tty in sclp_tty.c and sclp_vt220.c
Message-ID: <20041002145616.GA16071@devserv.devel.redhat.com>
References: <20041002125220.GA19908@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041002125220.GA19908@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 02, 2004 at 02:52:20PM +0200, Olaf Hering wrote:
> Alan,
> should that be sclp_tty and sclp_vt220_tty?

Yes. The patch is correct.
