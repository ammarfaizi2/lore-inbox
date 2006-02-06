Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750866AbWBFJqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbWBFJqQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 04:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbWBFJqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 04:46:16 -0500
Received: from [202.131.75.34] ([202.131.75.34]:19924 "EHLO
	mail.shaolinmicro.com") by vger.kernel.org with ESMTP
	id S1750866AbWBFJqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 04:46:14 -0500
Message-ID: <43E71AD7.5070600@shaolinmicro.com>
Date: Mon, 06 Feb 2006 17:45:59 +0800
From: David Chow <davidchow@shaolinmicro.com>
Organization: Shaolin Microsystems Ltd.
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Linux drivers management
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear maintainers,

Is there any work in Linux undergoing to separate Linux drivers and the 
the main kernel, and manage drivers using a package management system 
that only manages kernel drivers and modules? If this can be done, the 
kernel maintenance can be simple, and will end-up with a more stable 
(less frequent changed) kernel API for drivers, also make every 
developers of drivers happy.

Would like to see that happens .

regards,
David Chow
