Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265354AbUFYTmb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265354AbUFYTmb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 15:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265360AbUFYTmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 15:42:31 -0400
Received: from ms2.usu.edu ([129.123.104.12]:51678 "EHLO ms2.usu.edu")
	by vger.kernel.org with ESMTP id S265354AbUFYTm3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 15:42:29 -0400
X-WebMail-UserID: saiprathap
Date: Fri, 25 Jun 2004 13:38:54 -0600
From: saiprathap <saiprathap@cc.usu.edu>
To: linux-kernel@vger.kernel.org
X-EXP32-SerialNo: 00002751
Subject: 
Message-ID: <40DC7F7D@webster.usu.edu>
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

