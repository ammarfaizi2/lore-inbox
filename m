Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261980AbSJDPKI>; Fri, 4 Oct 2002 11:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261977AbSJDPJ4>; Fri, 4 Oct 2002 11:09:56 -0400
Received: from fw.openss7.com ([142.179.197.31]:31503 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id <S261971AbSJDPJq>;
	Fri, 4 Oct 2002 11:09:46 -0400
Date: Fri, 4 Oct 2002 09:15:17 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: Christoph Hellwig <hch@infradead.org>,
       kernel <linux-kernel@vger.kernel.org>
Subject: Re: export of sys_call_table
Message-ID: <20021004091517.H18191@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	kernel <linux-kernel@vger.kernel.org>
References: <20021003153943.E22418@openss7.org> <20021004145845.A30064@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021004145845.A30064@infradead.org>; from hch@infradead.org on Fri, Oct 04, 2002 at 02:58:45PM +0100
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph,

On Fri, 04 Oct 2002, Christoph Hellwig wrote:
> 
> There is no such thing as iBCS for 2.4+.  iBCS/Linux-ABI are for foreign
> personalities only anyway and don't need to touch sys_call_table.
> 

iBCS is right there in arch/sparc64/solaris/socksys.c, timod.c, systbl.S

--brian
