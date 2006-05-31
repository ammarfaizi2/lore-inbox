Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964950AbWEaLER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964950AbWEaLER (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 07:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964962AbWEaLER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 07:04:17 -0400
Received: from po.coware.com ([63.236.49.244]:8652 "EHLO CoWare.com")
	by vger.kernel.org with ESMTP id S964950AbWEaLER (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 07:04:17 -0400
Message-ID: <447D782C.5030003@coware.com>
Date: Wed, 31 May 2006 13:04:12 +0200
From: Harald Dunkel <harald@CoWare.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060517)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: forcedeth 0.49 slows down vmware
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

Since I use forcedeth 0.49 the network connection for a virtual
PC running within VMware got horrible slow. The problem has
been discussed in

http://www.vmware.com/community/thread.jspa?messageID=408893
http://forums.fedoraforum.org/forum/showthread.php?t=105185

for example. Unfortunately the suggested workarounds don't
work for forcedeth.

I could reproduce the problem with the current 2.6.17-rc5.
Any helpful hint would be highly appreciated.


Regards

Harri


