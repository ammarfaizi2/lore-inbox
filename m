Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265365AbUADWMI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 17:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265378AbUADWMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 17:12:07 -0500
Received: from adsl-065-081-070-095.sip.gnv.bellsouth.net ([65.81.70.95]:53987
	"helo x") by vger.kernel.org with SMTP id S265365AbUADWL5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 17:11:57 -0500
From: tomwallard@soon.com
To: linux-kernel@vger.kernel.org
Subject: Any hope for HPT372/HPT374 IDE controller?
Message-Id: <S265365AbUADWL5/20040104221159Z+4976@vger.kernel.org>
Date: Sun, 4 Jan 2004 17:11:57 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Many people seem to have problems with the Highpoint HPT372 and HPT374 IDE
controllers. Several months ago there was a thread in which many people
reported failure and not many people reported success. For example, "hdX:
lost interrupt" errors right before a crash are a common problem. This was
happening over a wide range of kernel versions. In my case it happens more
quickly if there is heavy network or video load at the same time as heavy
load on this controller. (This is a motherboard with a KT400 chipset).
                                                                                                    
Have any recent improvements been made? Does anyone have one of these controllers actually working correctly? Does anyone have any idea where to
begin tracking this problem down?
