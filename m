Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161010AbWHRPOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161010AbWHRPOX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 11:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161009AbWHRPOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 11:14:23 -0400
Received: from ozlabs.tip.net.au ([203.10.76.45]:60039 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1161004AbWHRPOW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 11:14:22 -0400
Date: Sat, 19 Aug 2006 01:13:40 +1000
From: Anton Blanchard <anton@samba.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Jan-Bernd Themann <ossthema@de.ibm.com>, netdev@vger.kernel.org,
       Christoph Raisch <raisch@de.ibm.com>,
       Jan-Bernd Themann <themann@de.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ppc <linuxppc-dev@ozlabs.org>, Marcus Eder <meder@de.ibm.com>,
       Thomas Klein <osstklei@de.ibm.com>, Thomas Klein <tklein@de.ibm.com>
Subject: Re: [2.6.19 PATCH 2/7] ehea: pHYP interface
Message-ID: <20060818151340.GB27947@krispykreme>
References: <200608181330.21507.ossthema@de.ibm.com> <20060818150600.GG5201@martell.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060818150600.GG5201@martell.zuzino.mipt.ru>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi,

> I asked SO to recount arguments and we've come to a conclusion that
> there're in fact 19 args not 18 as the name suggests. 19 args is
> I-N-S-A-N-E.

It will be partially cleaned up by:

http://ozlabs.org/pipermail/linuxppc-dev/2006-July/024556.html

However it doesnt fix the fact someone has architected such a crazy
interface :(

Anton
