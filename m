Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276768AbRJHC1f>; Sun, 7 Oct 2001 22:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276766AbRJHC1Z>; Sun, 7 Oct 2001 22:27:25 -0400
Received: from 205-158-62-105.outblaze.com ([205.158.62.105]:58553 "HELO
	ws4-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S276765AbRJHC1N>; Sun, 7 Oct 2001 22:27:13 -0400
Message-ID: <20011008022738.20248.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Jonathan Thorpe" <general@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Mon, 08 Oct 2001 10:27:38 +0800
Subject: Initrd on 2.4.10, any way to use 2.4.10 but use 2.4.9s initrd?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.4.10, the initrd support appears to be broken. When loading the initrd at startup, it appears to try and load the initrd, but immediately after initialising, it says "unloaded initrd, xxxx kb freed" and then goes into a panic (because there's no root or init).

Is it possible to use the 2.4.10 Kernel but with 2.4.9's initrd support? What would I do in order to take the code over?

Any help would be appreciated.

Thanks,
Jon
-- 

Get your free email from www.linuxmail.org 


Powered by Outblaze
