Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317895AbSGPRLH>; Tue, 16 Jul 2002 13:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317899AbSGPRLG>; Tue, 16 Jul 2002 13:11:06 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:40154 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S317895AbSGPRLF>; Tue, 16 Jul 2002 13:11:05 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200207161713.g6GHDhw02197@devserv.devel.redhat.com>
Subject: Re: Linux 2.4.19-rc1-ac5
To: andre@linux-ide.org (Andre Hedrick)
Date: Tue, 16 Jul 2002 13:13:43 -0400 (EDT)
Cc: kasperd@daimi.au.dk (Kasper Dupont), alan@redhat.com (Alan Cox),
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10207161003300.6509-100000@master.linux-ide.org> from "Andre Hedrick" at Jul 16, 2002 10:07:28 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The problem is not introduced by the patches, is the the hardware
> decoupling the GPIO used for HOST side cable detection.  Worse is they
> reused the GPIO for something else.

So how come it worked before.
