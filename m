Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314071AbSDKOWx>; Thu, 11 Apr 2002 10:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314074AbSDKOWw>; Thu, 11 Apr 2002 10:22:52 -0400
Received: from ztxmail05.ztx.compaq.com ([161.114.1.209]:7180 "EHLO
	ztxmail05.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S314071AbSDKOWv>; Thu, 11 Apr 2002 10:22:51 -0400
Subject: [PATCH] 2.5: task cpu affinity syscalls
From: "Aneesh Kumar K.V" <aneesh.kumar@digital.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: rml@tech9.net
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 11 Apr 2002 19:53:52 +0530
Message-Id: <1018535032.19511.75.camel@satan.xko.dec.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

 Now that we have API that allow a process to say I would like to go to
these  CPU, Are there any API's available that will allow a CPU to say I
will take only these process. ( Resource Affinity domains ? )

 -aneesh 




