Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290208AbSAWXfB>; Wed, 23 Jan 2002 18:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290207AbSAWXev>; Wed, 23 Jan 2002 18:34:51 -0500
Received: from svr3.applink.net ([206.50.88.3]:57607 "EHLO svr3.applink.net")
	by vger.kernel.org with ESMTP id <S290217AbSAWXei>;
	Wed, 23 Jan 2002 18:34:38 -0500
Message-Id: <200201232331.g0NNVTL01437@home.ashavan.org.>
Content-Type: text/plain; charset=US-ASCII
From: Timothy Covell <timothy.covell@ashavan.org>
Reply-To: timothy.covell@ashavan.org
To: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Daniel Nofftz <nofftz@castor.uni-trier.de>,
        Timothy Covell <timothy.covell@ashavan.org>
Subject: Re: [patch] amd athlon cooling on KT133A sensor lockup
Date: Thu, 24 Jan 2002 17:33:12 -0600
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.40.0201232021440.2202-100000@infcip10.uni-trier.de> <20020123202258Z290054-13996+10694@vger.kernel.org>
In-Reply-To: <20020123202258Z290054-13996+10694@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I tried lvcool on my KT133A/Duron system.  When I ran the
"sensors" program, it failed to exit and ate up 100% of the
CPU.  Kill -9 refused to kill it.  I had to reboot to clear the
problem which doesn't show up if I haven't run lvcool....

-- 
timothy.covell@ashavan.org.
