Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279926AbRJ3Lop>; Tue, 30 Oct 2001 06:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279927AbRJ3Lod>; Tue, 30 Oct 2001 06:44:33 -0500
Received: from mailb.telia.com ([194.22.194.6]:21770 "EHLO mailb.telia.com")
	by vger.kernel.org with ESMTP id <S279926AbRJ3LoT>;
	Tue, 30 Oct 2001 06:44:19 -0500
Date: Tue, 30 Oct 2001 12:39:27 +0100
From: Johan <jo_ni@telia.com>
To: linux-kernel@vger.kernel.org
Subject: Still having problems with eepro100
Message-Id: <20011030123927.74e26501.jo_ni@telia.com>
X-Mailer: Sylpheed version 0.6.4 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,
Does anyone except me still having problems with the eepro100 drivers ?

The network connection stalls and I'll get this message:

eepro100: wait_for_cmd_done timeout!

I am using the eepro100 drivers with my 100/10 card running in
10mbit and it works in windows.

I have been trying all new kernels + the ac patches but nothing
seems to work. The fun thing is that I only gets this problem
when I am running XFree, is this just a weird coincidence?

/Johan Nilsson
