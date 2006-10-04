Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbWJDVdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbWJDVdU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 17:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbWJDVdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 17:33:20 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48778 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751147AbWJDVdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 17:33:19 -0400
Subject: Re: removed sysctl system call - documentation and timeline
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <9a8748490610041335t519678d1u61f5775293c061e4@mail.gmail.com>
References: <9a8748490610041335t519678d1u61f5775293c061e4@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 04 Oct 2006 22:58:58 +0100
Message-Id: <1159999139.25772.118.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-10-04 am 22:35 +0200, ysgrifennodd Jesper Juhl:
> I'm not, as such, opposed to removing sysctl (and yes, I know what it
> is and what it does). What I am a little opposed to is that it is
> being removed on such short notice (unless I missed the memo) and that
> it is hidden inside EMBEDDED.

It was deprecated but 6 months for a syscall is way too short and it
should have been (and still should - send Linus patches and I'm sure
lots of people will ack them) under EMBEDDED

Alan

