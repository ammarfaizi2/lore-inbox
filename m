Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262416AbTCRNzR>; Tue, 18 Mar 2003 08:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262417AbTCRNzR>; Tue, 18 Mar 2003 08:55:17 -0500
Received: from dsl-212-23-25-139.zen.co.uk ([212.23.25.139]:48068 "EHLO
	butternut.transitive.com") by vger.kernel.org with ESMTP
	id <S262416AbTCRNzQ>; Tue, 18 Mar 2003 08:55:16 -0500
Message-ID: <3E772782.7090305@treblig.org>
Date: Tue, 18 Mar 2003 14:04:50 +0000
From: "Dave Gilbert (Home)" <gilbertd@treblig.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: linux-kernel@vger.kernel.org, ext3-users@redhat.com
Subject: Re: 2.4.20: ext3/raid5 - allocating block in system zone/multiple
 1 requests for sector
References: <20030316150148.GC1148@gallifrey> <15990.28660.687262.457216@notabene.cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:

> The bug I found was specific to data=journal mode, and this certainly
> has more options for buffer aliasing.  Were you using data=journal?

No.

Dave


