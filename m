Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312877AbSCVW0f>; Fri, 22 Mar 2002 17:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312876AbSCVW0Z>; Fri, 22 Mar 2002 17:26:25 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:18855 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S312877AbSCVW0P>;
	Fri, 22 Mar 2002 17:26:15 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [PATCH] get_pid() performance fix
Date: Fri, 22 Mar 2002 17:26:52 -0500
X-Mailer: KMail [version 1.3.1]
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, <davej@suse.de>,
        <marcelo@cnectiva.com.br>, Rajan Ravindran <rajancr@us.ibm.com>,
        <linux-kernel@vger.kernel.org>, <lse-tech@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0203221425550.1434-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020322222607.273BC3FE06@smtp.linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 22 March 2002 05:28 pm, Davide Libenzi wrote:
> On Fri, 22 Mar 2002, Hubertus Franke wrote:
> > I implemented an alternative version of getpid, that for large thread
> > counts ( > 220000), provides "significantly" better performance as shown
> > in attached
>
>       ^^^^^^
> You've a very nice system Hubertus because it's about 1.8Gb only for the
> stack :-)
>
>
>
> - Davide


Friday evening alert. Already thinking about the pub...
Meant 22000-25000.


-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
