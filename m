Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313628AbSDPILE>; Tue, 16 Apr 2002 04:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313630AbSDPILD>; Tue, 16 Apr 2002 04:11:03 -0400
Received: from goliath.sylaba.poznan.pl ([195.216.104.3]:33999 "EHLO
	goliath.sylaba.poznan.pl") by vger.kernel.org with ESMTP
	id <S313628AbSDPILC>; Tue, 16 Apr 2002 04:11:02 -0400
Date: Tue, 16 Apr 2002 09:47:48 +0200
From: Olaf Fraczyk <olaf@navi.pl>
To: linux-kernel@vger.kernel.org
Subject: Why HZ on i386 is 100 ?
Message-ID: <20020416074748.GA16657@venus.local.navi.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I would like to know why exactly this value was choosen.
Is it safe to change it to eg. 1024? Will it break anything?
What else should I change to get it working:
CLOCKS_PER_SEC?
Please CC me.

Regards,

Olaf Fraczyk


