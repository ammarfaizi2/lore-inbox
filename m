Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269333AbTCDIEq>; Tue, 4 Mar 2003 03:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269334AbTCDIEq>; Tue, 4 Mar 2003 03:04:46 -0500
Received: from dsl-213-023-050-047.arcor-ip.net ([213.23.50.47]:52877 "EHLO
	pulsar.homelinux.net") by vger.kernel.org with ESMTP
	id <S269333AbTCDIEp>; Tue, 4 Mar 2003 03:04:45 -0500
Message-ID: <3E646091.6070004@pulsar.homelinux.net>
Date: Tue, 04 Mar 2003 09:15:13 +0100
From: Uwe Reimann <linux-kernel@pulsar.homelinux.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030121
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Direct access to parport
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'd like to connect some self made hardware to the parallel port and 
read the values of the dataline using linux. Can this be done in 
userspace or do I have to write kernel code to do so? I'm currently 
thinking of writing a device like lp, which in turn uses the parport 
device. Does this sound like a good idea?

Regards, Uwe


