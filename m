Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312872AbSCVWXZ>; Fri, 22 Mar 2002 17:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312874AbSCVWXQ>; Fri, 22 Mar 2002 17:23:16 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:40068 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S312872AbSCVWXF>; Fri, 22 Mar 2002 17:23:05 -0500
X-AuthUser: davidel@xmailserver.org
Date: Fri, 22 Mar 2002 14:28:04 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Hubertus Franke <frankeh@watson.ibm.com>
cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, <davej@suse.de>,
        <marcelo@cnectiva.com.br>, Rajan Ravindran <rajancr@us.ibm.com>,
        <linux-kernel@vger.kernel.org>, <lse-tech@lists.sourceforge.net>
Subject: Re: [PATCH] get_pid() performance fix
In-Reply-To: <20020322221318.5F6083FE06@smtp.linux.ibm.com>
Message-ID: <Pine.LNX.4.44.0203221425550.1434-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Mar 2002, Hubertus Franke wrote:

> I implemented an alternative version of getpid, that for large thread counts
> ( > 220000), provides "significantly" better performance as shown in attached
      ^^^^^^
You've a very nice system Hubertus because it's about 1.8Gb only for the
stack :-)



- Davide


