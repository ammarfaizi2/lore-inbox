Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262312AbSJDQO2>; Fri, 4 Oct 2002 12:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262313AbSJDQO1>; Fri, 4 Oct 2002 12:14:27 -0400
Received: from gw.openss7.com ([142.179.199.224]:22032 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id <S262312AbSJDQO0>;
	Fri, 4 Oct 2002 12:14:26 -0400
Date: Fri, 4 Oct 2002 10:19:59 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: export of sys_call_table
Message-ID: <20021004101959.N18191@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	linux-kernel@vger.kernel.org
References: <20021003153943.E22418@openss7.org> <20021004145845.A30064@infradead.org> <20021004091517.H18191@openss7.org> <20021004162818.A2670@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021004162818.A2670@infradead.org>; from hch@infradead.org on Fri, Oct 04, 2002 at 04:28:19PM +0100
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph,

On Fri, 04 Oct 2002, Christoph Hellwig wrote:
> > 
> > iBCS is right there in arch/sparc64/solaris/socksys.c, timod.c, systbl.S
> 
> No that's not iBCS.  Even if some code is derivaed it's ceratainly something
> different.

If you consider 99% some...

--brian

-- 
Brian F. G. Bidulock    ¦ The reasonable man adapts himself to the ¦
bidulock@openss7.org    ¦ world; the unreasonable one persists in  ¦
http://www.openss7.org/ ¦ trying  to adapt the  world  to himself. ¦
                        ¦ Therefore  all  progress  depends on the ¦
                        ¦ unreasonable man. -- George Bernard Shaw ¦
