Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275919AbTHOMAj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 08:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275922AbTHOMAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 08:00:39 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:5570 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S275919AbTHOMAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 08:00:38 -0400
Date: Fri, 15 Aug 2003 12:59:49 +0100
From: Dave Jones <davej@redhat.com>
To: Christoph Hellwig <hch@infradead.org>,
       Jonathan Morton <chromi@chromatix.demon.co.uk>,
       Robert Toole <tooler@tooleweb.homelinux.com>,
       linux-kernel@vger.kernel.org
Subject: Re: agpgart failure on KT400
Message-ID: <20030815115948.GF22433@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Jonathan Morton <chromi@chromatix.demon.co.uk>,
	Robert Toole <tooler@tooleweb.homelinux.com>,
	linux-kernel@vger.kernel.org
References: <3F3C2DA0.1030504@tooleweb.homelinux.com> <BD8AF95A-CEC1-11D7-A88B-003065664B7C@chromatix.demon.co.uk> <20030815105733.GC22433@redhat.com> <20030815124055.A8940@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030815124055.A8940@infradead.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 15, 2003 at 12:40:55PM +0100, Christoph Hellwig wrote:
 > On Fri, Aug 15, 2003 at 11:57:33AM +0100, Dave Jones wrote:
 > > is at least a few evenings work.  I'm just one guy.  Unless Red Hat
 > > decide that AGP3 is something they really really must have for some
 > > future 2.4 release, it isn't going to happen by me. Period.
 > > I'm just up to my eyes in other work.
 > 
 > Red Hat has merged the crap AGP3 patches for 2.4 in AS3.0 at least..

*nod*. It doesn't buy you anything for AGP3 chipsets other than
Intel E7x05 however, and as history has shown in 2.5, it wasn't
the 'generic' be-all-end-all answer to AGP3 support.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
