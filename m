Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262310AbVCJH57@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262310AbVCJH57 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 02:57:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262338AbVCJH56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 02:57:58 -0500
Received: from [217.222.53.238] ([217.222.53.238]:1716 "EHLO mail.gts.it")
	by vger.kernel.org with ESMTP id S262310AbVCJH5o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 02:57:44 -0500
Message-ID: <422FFDEF.2060706@gts.it>
Date: Thu, 10 Mar 2005 08:57:35 +0100
From: Stefano Rivoir <s.rivoir@gts.it>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8a6) Gecko/20050111
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-mm2
References: <20050308033846.0c4f8245.akpm@osdl.org>
In-Reply-To: <20050308033846.0c4f8245.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11-mm2/

Hi Andrew

With 2.6.11-mm series, "acpi_poweroff called" problem is back again (it 
disappeared in 2.6.11-rc-mm and actually never happend in Linus' tree). 
So when you shutdown, you have to unplug power cord or so to switch off 
because the system hangs after that message is displayed.

Bye

-- 
Stefano RIVOIR

