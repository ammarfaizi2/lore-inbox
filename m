Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273258AbRINC1z>; Thu, 13 Sep 2001 22:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273260AbRINC1p>; Thu, 13 Sep 2001 22:27:45 -0400
Received: from nwcst280.netaddress.usa.net ([204.68.23.25]:55757 "HELO
	nwcst280.netaddress.usa.net") by vger.kernel.org with SMTP
	id <S273258AbRINC1e> convert rfc822-to-8bit; Thu, 13 Sep 2001 22:27:34 -0400
Message-ID: <20010914022756.9487.qmail@nwcst280.netaddress.usa.net>
Date: 13 Sep 2001 21:27:56 CDT
From: shreenivasa H V <shreenihv@usa.net>
To: linux-kernel@vger.kernel.org
Subject: scheduler policy
X-MSMail-Priority: High
X-Priority: 1
X-Mailer: USANET web-mailer (34FM.0700.21.01)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In process scheduling, when an epoch ends because of the current process
completing its time quantum (and all the runnable ones having finished their
respective quantums), at the start of the new epoch, will the current running
process retain the cpu (assuming all the runnable ones are of the same
priority)?

Can anyone give some pointers as to where I can find detailed info for linux
process scheduling.

thanks,
shreeni.
