Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262231AbVFSLNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262231AbVFSLNi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 07:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262233AbVFSLNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 07:13:38 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:33004
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S262231AbVFSLNg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 07:13:36 -0400
Subject: Re: [patch 2.6.12] getmonotonictime system call and patch for
	evdev to use such time
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Michal =?iso-8859-2?Q?Maru=B9ka?= <mmc@maruska.dyndns.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m2ekayaban.fsf@linux11.maruska.tin.it>
References: <m2ekayaban.fsf@linux11.maruska.tin.it>
Content-Type: text/plain; charset=iso-8859-2
Organization: linutronix
Date: Sun, 19 Jun 2005 13:15:10 +0200
Message-Id: <1119179710.30192.140.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-06-19 at 12:30 +0200, Michal Maru¹ka wrote:

> I found  do_posix_clock_monotonic_gettime  and made simple wrapper around it.
> I do NOT claim i know how to add a new system call! And it's  i386 only.

There is a system call already.

man clock_gettime

tglx


