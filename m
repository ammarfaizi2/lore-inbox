Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310552AbSCPT6V>; Sat, 16 Mar 2002 14:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310540AbSCPT6L>; Sat, 16 Mar 2002 14:58:11 -0500
Received: from CPE00403333780e.cpe.net.cable.rogers.com ([24.112.22.235]:55047
	"EHLO tentacle.dhs.org") by vger.kernel.org with ESMTP
	id <S310547AbSCPT6C>; Sat, 16 Mar 2002 14:58:02 -0500
Date: Sat, 16 Mar 2002 14:42:33 -0500
To: linux-kernel@vger.kernel.org
Subject: ext3_error()
Message-ID: <20020316194233.GA26338@tentacle.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
From: John McCutchan <ttb@tentacle.dhs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I got this in my kern.log file:

Feb 20 00:41:00 golbez kernel: ext3_free_blocks: Freeing blocks not in datazone
- block = 538082710, count = 1

What could be the cause of this?

John
