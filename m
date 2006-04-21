Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbWDUMx1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbWDUMx1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 08:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbWDUMx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 08:53:27 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:4317 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932217AbWDUMx0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 08:53:26 -0400
Date: Fri, 21 Apr 2006 14:53:17 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Lukasz Stelmach <stlman@poczta.fm>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: unix socket connection tracking 
In-Reply-To: <44480BD9.5080100@poczta.fm>
Message-ID: <Pine.LNX.4.61.0604211452490.23180@yvahk01.tjqt.qr>
References: <44480BD9.5080100@poczta.fm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I feel dumb as never so please enlight me. Is ther a way to find out which
>process is on the other end of a unix socket pointed by a specified fd in a process.

getpeer*()



Jan Engelhardt
-- 
