Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262248AbULCPLr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262248AbULCPLr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 10:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262258AbULCPLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 10:11:47 -0500
Received: from static64-74.dsl-blr.eth.net ([61.11.64.74]:1028 "EHLO
	globaledgesoft.com") by vger.kernel.org with ESMTP id S262248AbULCPLn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 10:11:43 -0500
Message-ID: <41B081AE.3000509@globaledgesoft.com>
Date: Fri, 03 Dec 2004 20:39:34 +0530
From: krishna <krishna.c@globaledgesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: How to understand flow of kernel code
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-MDRemoteIP: 172.16.6.42
X-Return-Path: krishna.c@globaledgesoft.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Elladan,

    Thank you very much.
    Can u tell me how can I start from an interrupt.

Regards,
Krishna Chaitanya

Elladan wrote:

It's written in C, so it should be quite simple.

Most everything starts from a syscall, or an interrupt.  

-J

On Thu, Dec 02, 2004 at 10:16:54AM +0530, krishna wrote:
  

Hi,

Can Anyone tell me the tips/tricks/techniques/practices followed in 
understanding flow of Linux kernel code?

Regards,
Krishna Chaitanya

