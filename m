Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262529AbTIENt4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 09:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262514AbTIENtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 09:49:55 -0400
Received: from mail3.itu.edu.tr ([160.75.2.7]:45517 "EHLO mail3.itu.edu.tr")
	by vger.kernel.org with ESMTP id S262529AbTIENto (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 09:49:44 -0400
Message-ID: <3F589054.5030100@itu.edu.tr>
Date: Fri, 05 Sep 2003 16:32:04 +0300
From: "O.Sezer" <oosezer@itu.edu.tr>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.3.1) Gecko/20030425
X-Accept-Language: tr,en,pdf
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Robert.L.Harris@rdlg.net
Subject: Re: 2.4.22-bk10 and ALSA 0.9.6
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-0.1, required 8,
	USER_AGENT_MOZILLA_UA 0.00, X_ACCEPT_LANG -0.10)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This should fix it:
http://cvs.alsa-project.org/cgi-bin/viewcvs.cgi/alsa/alsa-driver/include/adriver.h.diff?r1=1.53&r2=1.54&diff_format=u

