Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265200AbUAOCf3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 21:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265828AbUAOCf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 21:35:29 -0500
Received: from korana.vuka.hr ([193.198.2.3]:13293 "EHLO korana.vuka.hr")
	by vger.kernel.org with ESMTP id S265200AbUAOCfY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 21:35:24 -0500
Message-ID: <4005FD33.5000606@vuka.hr>
Date: Thu, 15 Jan 2004 03:38:43 +0100
From: Sasa Poznanovic <sasa.poznanovic@vuka.hr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031010
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Cpqarray eisa problem
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have a problem with EISA Smart2/E raid controller on an old Compaq 
Proliant 1000 server. With 2.4.18 everything works fine, but with 2.4.22 
or newer kernel the board is not recognized. The driver is compiled into 
the kernel, not as a module, configuration is the same.
Are there any know issues with EISA boards and newer kernels???

Thanks
Sasa

