Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751775AbWJ0SQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751775AbWJ0SQR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 14:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752298AbWJ0SQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 14:16:17 -0400
Received: from ms01.sssup.it ([193.205.80.99]:60866 "EHLO sssup.it")
	by vger.kernel.org with ESMTP id S1751775AbWJ0SQQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 14:16:16 -0400
Message-ID: <45424CEF.7010808@gandalf.sssup.it>
Date: Fri, 27 Oct 2006 20:16:15 +0200
From: Michael Trimarchi <trimarchi@gandalf.sssup.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: arm920t s3c24xx
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm working on an s3c2410 and I notice that in the kernel there is not a
function to read the bus mode of the arm920t. The kernel may fail to
report the correct frequencies of the core to the user level. It can
read the cp15 register to show the core frequency that can be taken from
the amba bus or the flck.

Regards Michael


