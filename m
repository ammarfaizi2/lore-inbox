Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132755AbRDIOFJ>; Mon, 9 Apr 2001 10:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132756AbRDIOEt>; Mon, 9 Apr 2001 10:04:49 -0400
Received: from nakyup.mizi.com ([203.239.30.70]:45529 "EHLO nakyup.mizi.com")
	by vger.kernel.org with ESMTP id <S132755AbRDIOEi>;
	Mon, 9 Apr 2001 10:04:38 -0400
Date: Mon, 9 Apr 2001 23:04:33 +0900
From: "Young-Ho. Cha" <ganadist@nakyup.mizi.com>
To: linux-kernel@vger.kernel.org
Subject: SMP kernel has died in using usb keyboard
Message-ID: <20010409230433.A16892@nakyup.mizi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi kernel hackers.

I have found problem in using usb keyboard.

non-SMP kernel has no problem, but SMP kernel has died pressing numlock key twice.

anybody has patch against that?
