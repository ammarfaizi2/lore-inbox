Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130612AbRBMHTJ>; Tue, 13 Feb 2001 02:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130741AbRBMHS7>; Tue, 13 Feb 2001 02:18:59 -0500
Received: from sfovwl03.infy.com ([206.236.143.9]:57606 "HELO
	sfovwl03.infy.com") by vger.kernel.org with SMTP id <S130612AbRBMHSo>;
	Tue, 13 Feb 2001 02:18:44 -0500
Message-ID: <426C1E9EBA27D411839000D0B74752F83E33E5@punmsg02.ad.infosys.com>
From: nomit kalidhar <nomit_kalidhar@infy.com>
To: linux-kernel@vger.kernel.org
Subject: Routing table change indication...
Date: Mon, 12 Feb 2001 23:19:53 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have been trying to get a solution to a minor problem but unfortunately i
have not been able to solve it or get some help on it and i am stuck up from
a long time.

Is there any way i can find out that there has been a change in the kernel
routing table in linux ?

In the file rtnetlink.h there is a rtm_flags feild RTM_F_NOTIFY which says
it notifies the user of route change but i have not been able to capture it
when there is a change in the routing table. 
Is this the right approach ??? 
please give some pointers..

with warm regards

Nomit Kalidhar  
