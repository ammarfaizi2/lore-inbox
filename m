Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293410AbSCAWkx>; Fri, 1 Mar 2002 17:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310142AbSCAWkp>; Fri, 1 Mar 2002 17:40:45 -0500
Received: from pizda.ninka.net ([216.101.162.242]:20874 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S293410AbSCAWkc>;
	Fri, 1 Mar 2002 17:40:32 -0500
Date: Fri, 01 Mar 2002 14:38:09 -0800 (PST)
Message-Id: <20020301.143809.91757055.davem@redhat.com>
To: rml@tech9.net
Cc: maxk@qualcomm.com, fisaksen@bewan.com, mitch@sfgoth.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spinlock not locked when unlocking in atm_dev_register
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1015022109.11499.47.camel@phantasy>
In-Reply-To: <20020301163936.7FA725F963@postfix2-2.free.fr>
	<5.1.0.14.2.20020301143010.0d552be8@mail1.qualcomm.com>
	<1015022109.11499.47.camel@phantasy>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Robert Love <rml@tech9.net>
   Date: 01 Mar 2002 17:35:08 -0500
    
   > btw ATM locking seems to be messed up. Is anybody working on that ?
   
   Not that I know of.  Volunteer? :)

I consider it pretty much unmaintained.  Feel free to take it
up :)
