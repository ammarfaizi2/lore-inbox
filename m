Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293074AbSCOS1w>; Fri, 15 Mar 2002 13:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293058AbSCOS1p>; Fri, 15 Mar 2002 13:27:45 -0500
Received: from isp.qnet.com.pe ([200.37.231.132]:64234 "HELO linux.qnet.com.pe")
	by vger.kernel.org with SMTP id <S293060AbSCOS1X>;
	Fri, 15 Mar 2002 13:27:23 -0500
Message-ID: <3C91B2DC.AAB49E5F@isp.qnet.com.pe>
Date: Fri, 15 Mar 2002 13:37:48 +0500
From: Jose Luis Marin Perez <jmarin@isp.qnet.com.pe>
Reply-To: jmarin@isp.qnet.com.pe
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.18 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: request_module[block-major-8]: Root fs not mounted
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have modified kernel in a RedHat-7.2 and in the compilation I have not

had problem, but when resumption with kernel modified leaves the
following error to me:

request_module[block-major-8]: Root fs not mounted
VFS: Cannot open root device 08:03
Kernel panic:VFS:Unbale to mount root fs on 08:03

In which I have failed?

Thanks

Jose Luis

