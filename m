Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263743AbUDZBXZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263743AbUDZBXZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 21:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263750AbUDZBXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 21:23:25 -0400
Received: from [80.28.158.205] ([80.28.158.205]:22024 "HELO
	medusa.homeunix.net") by vger.kernel.org with SMTP id S263743AbUDZBXX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 21:23:23 -0400
From: "Williams Parker" <listas@medusa.homeunix.net>
Date: Mon, 26 Apr 2004 03:11:01 +0200
To: linux-kernel@vger.kernel.org
Subject: speed interface ethernet 10/100Mbit/seg
Message-ID: <20040426011101.GA1798@sakroot.org>
References: <S262064AbUDYCEK/20040425020410Z+1117@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <S262064AbUDYCEK/20040425020410Z+1117@vger.kernel.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, i have troubles with speed in ethernet interface 


i have probed with transfer of files in samba to windows

speed max 1,44Mbytes/sec and it have about 8Mbytes/sec



info my hardisk


hdparm -t /dev/hdc

/dev/hdc:
 Timing buffered disk reads:   34 MB in  3.04 seconds =  11.18 MB/sec

 ok it´s mdma2 


 while i send archivos it low to 4,20Mbytes/sec  --->


 hdparm -t /dev/hdc

 /dev/hdc:
  Timing buffered disk reads:   14 MB in  3.10 seconds =   4.52 MB/sec



  why do it send to 7 or 8Mbytes/sec ???

  howto probe max speed??
 

