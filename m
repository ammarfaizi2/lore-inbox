Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316364AbSFDEp0>; Tue, 4 Jun 2002 00:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316372AbSFDEp0>; Tue, 4 Jun 2002 00:45:26 -0400
Received: from [202.65.66.93] ([202.65.66.93]:26373 "EHLO
	tuppy.pienetworks.com") by vger.kernel.org with ESMTP
	id <S316364AbSFDEpY>; Tue, 4 Jun 2002 00:45:24 -0400
Subject: ps/2 mouse issue
From: "Enzo D'addario" <enzo@pienetworks.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 04 Jun 2002 12:41:56 +0800
Message-Id: <1023165716.21515.25.camel@tuppy.pienetworks.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Previously with kernel 2.4.3 the ps/2 mouse could actually be HOT
unplugged and when plugged back in would resume normal operation
immediately.

If  this is attempted with either kernel 2.4.8 or kernel 2.4.18 the
mouse remains frozen and will only resume normal operation if I switch
consoles and then switch back or restart X. 

Any comments/answers would be greatly appreciated...

Thanks

Enzo Daddario...



