Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316582AbSG3VX2>; Tue, 30 Jul 2002 17:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316587AbSG3VX2>; Tue, 30 Jul 2002 17:23:28 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:51769 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S316582AbSG3VX0>; Tue, 30 Jul 2002 17:23:26 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200207302126.g6ULQnu19724@devserv.devel.redhat.com>
Subject: Re: Linux 2.4.19rc3-ac5
To: terje_fb@yahoo.no (=?iso-8859-1?q?Terje=20F=E5berg?=)
Date: Tue, 30 Jul 2002 17:26:49 -0400 (EDT)
Cc: alan@redhat.com (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20020730212013.5866.qmail@web12904.mail.yahoo.com> from "=?iso-8859-1?q?Terje=20F=E5berg?=" at Jul 30, 2002 11:20:13 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How safe is it to use gcc-3.1?

Im currently using gcc 3.1 with some patches. It seems to be working
although on 2.5 I've had compiler aborts in trident.c
