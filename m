Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266855AbUFYVYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266855AbUFYVYa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 17:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266856AbUFYVYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 17:24:30 -0400
Received: from ms1.usu.edu ([129.123.104.11]:25017 "EHLO ms1.usu.edu")
	by vger.kernel.org with ESMTP id S266855AbUFYVY2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 17:24:28 -0400
X-WebMail-UserID: saiprathap
Date: Fri, 25 Jun 2004 15:20:50 -0600
From: saiprathap <saiprathap@cc.usu.edu>
To: linux-kernel@vger.kernel.org
X-EXP32-SerialNo: 00002751
Subject: TCP-RST Vulnerability - Doubt
Message-ID: <40DC9B00@webster.usu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: WebMail (Hydra) SMTP v3.62
X-USU-MailScanner-Information: Please contact the ISP for more information
X-USU-MailScanner: Found to be clean
X-MailScanner-From: saiprathap@cc.usu.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am a graduate research student majoring in the field of
Computer Networking.As part of my research I have sorted out what FreeBSD has 
done to overcome the TCP-RST vulnerability (by modifying the stack to accept 
the RST packets only with the current + 1 sequence number and ignoring the 
rest, even if their sequence numbers fall within the receiving window).

Could you kindly share your views regarding what Linux has done to its stack 
to overcome this vulnerability as it will be of great help to my research.

Thanks,
Sai Prathap

