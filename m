Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262111AbTIRKwd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 06:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262112AbTIRKwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 06:52:32 -0400
Received: from [213.229.38.66] ([213.229.38.66]:23187 "HELO mail.falke.at")
	by vger.kernel.org with SMTP id S262111AbTIRKwc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 06:52:32 -0400
Message-ID: <3F698DBC.1030102@winischhofer.net>
Date: Thu, 18 Sep 2003 12:49:32 +0200
From: Thomas Winischhofer <thomas@winischhofer.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en, de, de-de, de-at, sv
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: PCI (USB) problem on a laptop 
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



 > Summary: it looks like a bad PCI setup, which I need to work around.
 > A USB device is not assigned an interrupt.

Known problem, fixed in 2.4.23pre3.

Thomas

-- 
Thomas Winischhofer
Vienna/Austria
thomas AT winischhofer DOT net          *** http://www.winischhofer.net/
twini AT xfree86 DOT org





