Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316649AbSHOIrZ>; Thu, 15 Aug 2002 04:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316659AbSHOIrZ>; Thu, 15 Aug 2002 04:47:25 -0400
Received: from www.wen-online.de ([212.223.88.39]:7944 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S316649AbSHOIrZ>;
	Thu, 15 Aug 2002 04:47:25 -0400
Message-ID: <3D5B6AD6.1030503@gmx.de>
Date: Thu, 15 Aug 2002 10:48:22 +0200
From: Mike Galbraith <EFAULT@gmx.de>
User-Agent: Mozilla/5.0 (Windows; U; Win95; en-US; rv:0.9.4) Gecko/20011128 Netscape6/6.2.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [OT] scsi disk sector size question
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's gotta be a better place to ask this, but...

Greetings,

Is it possible to change scsi drive sector size?  Scsiinfo says no, which is
inconvenient if you're making images of ancient drives (ST4766N) and find
that some have 512 byte and others 1024 byte sectors.

Why on earth would a manufacturer [drives are really CDC] do this?

    -Mike

