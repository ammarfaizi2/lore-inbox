Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbVGVL1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVGVL1v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 07:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262079AbVGVL1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 07:27:50 -0400
Received: from smtp-31.ig.com.br ([200.226.132.31]:22965 "EHLO
	smtp-31.ig.com.br") by vger.kernel.org with ESMTP id S261249AbVGVL1f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 07:27:35 -0400
To: linux-kernel@vger.kernel.org
From: Vinicius <jdob@ig.com.br>
Subject: Kernel doesn't free Cached Memory
Date: Fri, 22 Jul 2005 08:27:30 -0300
X-Priority: 3 (Normal)
Message-ID: <20050722_112730_062779.jdob@ig.com.br>
X-Originating-IP: [10.17.1.76]172.31.47.254, 201.6.254.70
X-Mailer: iGMail [www.ig.com.br]
X-user: jdob@ig.com.br
Teste: asaes
MIME-Version: 1.0
Content-type: multipart/mixed;
	boundary="Message-Boundary-by-Mail-Sender-1122031650"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

--Message-Boundary-by-Mail-Sender-1122031650
Content-type: text/plain; charset=ISO-8859-1
Content-description: Mail message body
Content-transfer-encoding: 8bit
Content-disposition: inline

Hi all! 

   I have a server with 2 Pentium 4 HT processors and 32 GB of RAM, this 
server runs lots of applications that consume lots of memory to. When I stop 
this applications, the kernel doesn't free memory (the  memory still in use) 
and the server cache lots of memory (~27GB). When I start this applications, 
the kernel sends  "Out of Memory" messages and kill some random 
applications. 

   Anyone know how can I reduce the kernel cached memory on RHEL 3 (kernel 
2.4.21-32.ELsmp - Trial version)? There is a way to reduce the kernel cached 
memory utilization? 

Thanks in advance (sorry my bad english). 

Vinicius. 
Protolink Consultoria. 

--Message-Boundary-by-Mail-Sender-1122031650--

