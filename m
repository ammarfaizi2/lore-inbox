Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261263AbVCVORR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbVCVORR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 09:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbVCVORR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 09:17:17 -0500
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:23528 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S261263AbVCVORI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 09:17:08 -0500
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: Samsung 40G drive locking up 2.6.11
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-To: 7eggert@gmx.de
Date: Tue, 22 Mar 2005 15:21:41 +0100
References: <fa.gg9u7j2.1vm65hi@ifi.uio.no>
User-Agent: KNode/0.7.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1DDkGQ-0000t8-9g@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> wrote:

> dd if=/dev/hdc of=/dev/null with this disk
> kills the system. Drive may do it's work
> for minute or two, but then it does 'klak' sound.

Did you try shdiag or hutil from samsung.com?
