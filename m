Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750858AbVJFMqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbVJFMqf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 08:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750859AbVJFMqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 08:46:35 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:33285 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750856AbVJFMqe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 08:46:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=QYFrv+CLmfhtPEOrL9CUvuNG8lhlT7ItOYPRz+9rQKur83CLLTvbz7X16EPyxFmHh6SXOaoUPcaAKiw/VN+x3nUvokh8b4NPPjAEiR++SqyzCJTHZdIiX5qCH4VajDabBIQH9VmCjmNnXgEMCiExyajvxb3gp2eN4LETl0Eo7RY=
Date: Thu, 6 Oct 2005 14:46:23 +0200
From: Diego Calleja <diegocg@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Documenting kernel changes
Message-Id: <20051006144623.42129a14.diegocg@gmail.com>
X-Mailer: Sylpheed version 2.1.1 (GTK+ 2.8.3; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I've always found linux changelogs awful: either you read the (too short)
official announcement or the (too long) full changelog. 

So I recoleted info from several sources - official announcements, davej's
"post halloween" doc, Guillaume Boissiere's "linux kernel status", LWN,
googling, etc and put (me and FrankSorenson) all the 2.5.0 - 2.6.14-rc info
found in kernelnewbies' wiki:

http://wiki.kernelnewbies.org/LinuxChanges

which is updated even with incoming 2.6.14 features and it's very useful IMO

So I'm sending this message because maybe there's something missing in that
list. I was hoping that kernel developers could take a look and add it themselves
or correct it if something is wrong (or anwer this mail if you don't want to add it
yourself because you hate wikis). I hope you find this useful and can contribute
to keep it updated.
