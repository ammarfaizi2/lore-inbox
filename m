Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264990AbRGJJrj>; Tue, 10 Jul 2001 05:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264877AbRGJJr3>; Tue, 10 Jul 2001 05:47:29 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:47151 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S264874AbRGJJr0>; Tue, 10 Jul 2001 05:47:26 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200107100947.f6A9lRo04762@devserv.devel.redhat.com>
Subject: Re: [PATCH]  Minor misc SCSI tweaks
To: thockin@sun.com (Tim Hockin)
Date: Tue, 10 Jul 2001 05:47:27 -0400 (EDT)
Cc: alan@redhat.com, linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <3B4AABE2.99475E56@sun.com> from "Tim Hockin" at Jul 10, 2001 12:16:50 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Attached is a small patch fixing some minor misc. SCSI issues (Duncan
> Laurie's work).  These are against 2.4.6, for general inclusion.

Please recheck against 2.4.7pre-curent. There are a lotof scsi fixups done there
and they probably deal with most of the stuff you are also patching

