Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318546AbSH1Cj7>; Tue, 27 Aug 2002 22:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318591AbSH1Cj7>; Tue, 27 Aug 2002 22:39:59 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:59524 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S318546AbSH1Cj7>;
	Tue, 27 Aug 2002 22:39:59 -0400
Message-ID: <1030502655.3d6c38ffea46c@kolivas.net>
Date: Wed, 28 Aug 2002 12:44:15 +1000
From: conman@kolivas.net
To: linux-kernel@vger.kernel.org
Subject: kernel config in osdl testlab
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

WRT osdl.org tests on my patchset (http://kernel.kolivas.net)

Cliff

Thanks for your input. I've checked the tests you ran on my kernel patch -ck3 
and found that the kernel config was set at default which means preemptible and 
low latency were disabled. I dont see a way of changing the kernel config, and 
I need these enabled in the tests otherwise the tests are not useful. 
Suggestions?

Con Kolivas

