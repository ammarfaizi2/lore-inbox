Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261332AbUKNSsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbUKNSsm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 13:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbUKNSsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 13:48:42 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:61382 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261332AbUKNSsk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 13:48:40 -0500
Date: Sun, 14 Nov 2004 19:48:37 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Sylvain <autofr@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: question about module and undeinfed symbols.
In-Reply-To: <64b1faec04111410421d76b8fa@mail.gmail.com>
Message-ID: <Pine.LNX.4.53.0411141948020.30281@yvahk01.tjqt.qr>
References: <64b1faec04111410421d76b8fa@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>The fonction printk, is also undifened and exported with the same
>macro "export_symbol". but compilation doesnt complain about it!!

#include <linux/kernel.h>

>Am I missing a step somewhere?!


Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
