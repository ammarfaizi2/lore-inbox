Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310579AbSBRNd7>; Mon, 18 Feb 2002 08:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310586AbSBRNdt>; Mon, 18 Feb 2002 08:33:49 -0500
Received: from chello080108013015.34.11.vie.surfer.at ([80.108.13.15]:31731
	"EHLO quake.thinstuff.com") by vger.kernel.org with ESMTP
	id <S310579AbSBRNdh>; Mon, 18 Feb 2002 08:33:37 -0500
Subject: khubd zombie
From: Patrik Weiskircher <me@justp.at>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2+cvs.2002.01.28.09.00 
Date: 18 Feb 2002 14:33:13 +0100
Message-Id: <1014039193.523.42.camel@dev1lap>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

killall khubd results to:
10 ?        Z      0:00 [khubd <defunct>]

is this ok?
if not, how can i solve this?

Best Regards,
Patrik Weiskircher



