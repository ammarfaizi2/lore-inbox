Return-Path: <linux-kernel-owner+ralf=40uni-koblenz.de@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S313181AbSEMMNk>; Mon, 13 May 2002 08:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S313182AbSEMMNj>; Mon, 13 May 2002 08:13:39 -0400
Received: from [63.97.180.122] ([63.97.180.122]:28085 "EHLO acsints11.acsonline.com") by vger.kernel.org with ESMTP id <S313181AbSEMMNi>; Mon, 13 May 2002 08:13:38 -0400
Date: Mon, 13 May 2002 07:12:13 -0500 (CDT)
From: 310017912650-0001@t-dialin.net
Message-Id: <200205131212.HAA19764@acsints11.acsonline.com>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

,ImCrðM:úÁacsints10.acsonline.com63.97.180.116<linux-kernel-owner+brian.fiegel=40acs-inc.com@vger.kernel.org>c=us;a= ;p=acs;l=DALEXU010205130632KQK26KSGjCS;o men    <brian.fiegel@acs-inc.com>rfc822;brian.fiegel@acs-inc.comly@vqeEwLsReceived: from acsints10.acsonline.com (63.97.180.116 [63.97.180.116]) by dalexu01.exchange.acsad.acs-inc.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id KQK26KSG; Mon, 13 May 2002 01:32:45 -0500
Received: from vger.kernel.org (vger.kernel.org [209.116.70.75])
	by acsints10.acsonline.com (8.10.2+Sun/8.10.2) with ESMTP id g4D6XxY17591
	for <brian.fiegel@acs-inc.com>; Mon, 13 May 2002 01:33:59 -0500 (CDT)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315851AbSEMGcI>; Mon, 13 May 2002 02:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315855AbSEMGcH>; Mon, 13 May 2002 02:32:07 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:60642 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S315851AbSEMGcG>; Mon, 13 May 2002 02:32:06 -0400
Received: from fwd06.sul.t-online.de 
	by mailout02.sul.t-online.com with smtp 
	id 1779HG-00068F-0D; Mon, 13 May 2002 08:25:46 +0200
Received: from there (310017912650-0001@[217.0.226.242]) by fwd06.sul.t-online.com
	with smtp id 1779HB-01zk0WC; Mon, 13 May 2002 08:25:41 +0200
Content-Type: 	text/plain; charset=US-ASCII
From: oliver.kowalke@t-online.de (Oliver Kowalke)
To: linux-kernel@vger.kernel.org
Subject: error : preempt_count 1
Date: 	Mon, 13 May 2002 08:25:41 +0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <1779HB-01zk0WC@fwd06.sul.t-online.com>
X-Sender: 310017912650-0001@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: 	linux-kernel@vger.kernel.org

Hello,

after shutdown (kernel 2.5.15) I've got :

erro: halt[8635] exited with preempt_count 1

What does it mean?
so long,
Oliver
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
