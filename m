Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132484AbRAHV4M>; Mon, 8 Jan 2001 16:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132964AbRAHVzx>; Mon, 8 Jan 2001 16:55:53 -0500
Received: from c-025.static.AT.KPNQwest.net ([193.154.188.25]:41459 "EHLO
	stefan.sime.com") by vger.kernel.org with ESMTP id <S132484AbRAHVzh>;
	Mon, 8 Jan 2001 16:55:37 -0500
Date: Mon, 8 Jan 2001 22:54:51 +0100
From: Stefan Traby <stefan@hello-penguin.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: `rmdir .` doesn't work in 2.4
Message-ID: <20010108225451.A968@stefan.sime.com>
Reply-To: Stefan Traby <stefan@hello-penguin.com>
In-Reply-To: <20010108180857.A26776@athlon.random> <Pine.GSO.4.21.0101081236440.4061-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0101081236440.4061-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Mon, Jan 08, 2001 at 12:58:20PM -0500
Organization: Stefan Traby Services && Consulting
X-Operating-System: Linux 2.4.0-fijiji0 (i686)
X-APM: 100% 400 min
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2001 at 12:58:20PM -0500, Alexander Viro wrote:

> Shell equivalent is rmdir `pwd`. Also portable.

Very portable - not.

rmdir "`pwd`" !!!

-- 

  ciao - 
    Stefan

"     ( cd /lib ; ln -s libBrokenLocale-2.2.so libNiedersachsen.so )     "
    
Stefan Traby                Linux/ia32               fax:  +43-3133-6107-9
Mitterlasznitzstr. 13       Linux/alpha            phone:  +43-3133-6107-2
8302 Nestelbach             Linux/sparc       http://www.hello-penguin.com
Austria                                    mailto://st.traby@opengroup.org
Europe                                   mailto://stefan@hello-penguin.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
