Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261883AbTCYKVe>; Tue, 25 Mar 2003 05:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261885AbTCYKVe>; Tue, 25 Mar 2003 05:21:34 -0500
Received: from ethlife-b.ethz.ch ([129.132.202.8]:30155 "HELO
	ethlife-b.ethz.ch") by vger.kernel.org with SMTP id <S261883AbTCYKVd>;
	Tue, 25 Mar 2003 05:21:33 -0500
Mime-Version: 1.0
Message-Id: <p04320436baa5df6de6f0@[192.168.3.11]>
In-Reply-To: <20030323171955Z263126-25575+35740@vger.kernel.org>
References: <20030323171955Z263126-25575+35740@vger.kernel.org>
Date: Tue, 25 Mar 2003 11:32:26 +0100
To: linux-kernel@vger.kernel.org
From: Christian Jaeger <christian.jaeger@ethlife.ethz.ch>
Subject: Re: Need help for pci driver on powerpc
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your help, Benjamin and Alan.

It works now, the reason it didn't when I first used inb/outb was 
simply that I used the wrong I/O region :o}

Source available for those who are interested at
http://pflanze.mine.nu/~chris/linux/sensor/

Cheers
Christian.
