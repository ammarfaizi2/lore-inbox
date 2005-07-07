Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261292AbVGGLjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbVGGLjJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 07:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261310AbVGGLgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 07:36:12 -0400
Received: from effigent.net ([210.211.230.208]:46048 "EHLO effigent.net")
	by vger.kernel.org with ESMTP id S261292AbVGGLf4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 07:35:56 -0400
Message-ID: <42CD12A7.90106@effigent.net>
Date: Thu, 07 Jul 2005 17:01:51 +0530
From: raja <vnagaraju@effigent.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ipc
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
While working with posix ipc i used the function mq_open.
When i compiled using gcc i am getting error as
 
: undefined reference to `mq_open'
collect2: ld returned 1 exit status
 
will you please tell me how to avoid that.
 
Thanking you,
raja
