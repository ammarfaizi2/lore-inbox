Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264969AbTLKOQf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 09:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264971AbTLKOQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 09:16:35 -0500
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:28746 "EHLO
	smtp-out3.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S264969AbTLKOQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 09:16:33 -0500
Message-ID: <3FD87C40.9040803@blueyonder.co.uk>
Date: Thu, 11 Dec 2003 14:16:32 +0000
From: Sid Boyce <sboyce@blueyonder.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: No VT console on 2.6.0-test11
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Dec 2003 14:16:41.0660 (UTC) FILETIME=[660C1FC0:01C3BFF1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've had this on other 2.6.0-test kernels, but not on 2.6.0-pre ones, 
using a GEForce FX5200 adapter and Athlon XP2200+. I have to set 
vga=normal in order to see the bootup messages, looks like a FB bug.
 CONFIG_VT=y
CONFIG_VT_CONSOLE=y
Regards
Sid.

-- 
Sid Boyce .... Linux Only Shop.

