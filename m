Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263228AbUAURoq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 12:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263639AbUAURoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 12:44:46 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:14982 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S263228AbUAURop
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 12:44:45 -0500
Subject: Re: My USB pendrive broke in 2.6.1
From: Omkhar Arasaratnam <iamroot@ca.ibm.com>
To: Bradley Chapman <kakadu_croc@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040121172837.79127.qmail@web40909.mail.yahoo.com>
References: <20040121172837.79127.qmail@web40909.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1074706992.1716.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 21 Jan 2004 12:43:12 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-01-21 at 12:28, Bradley Chapman wrote:
> Confirmed - the USB pendrive works perfectly fine without any errors in both Linux
> 2.6.0 and Windows XP.
> 
> Where should I look first for changes between .0 and .1, to troubleshoot this?

ChangeLog / bk log are good places

Or you could just do a diff between the two drivers/usb/ directories
-- 
Omkhar

