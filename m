Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932599AbWCAH0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932599AbWCAH0E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 02:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932602AbWCAH0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 02:26:04 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:33190 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932599AbWCAH0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 02:26:03 -0500
Subject: Re: Max mem space per process under  2.6.13-15.7-smp
From: Arjan van de Ven <arjan@infradead.org>
To: kilampka@gmail.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1141170947.23172.18.camel@pclampka.informatik.unibw-muenchen.de>
References: <1141170947.23172.18.camel@pclampka.informatik.unibw-muenchen.de>
Content-Type: text/plain
Date: Wed, 01 Mar 2006 08:25:29 +0100
Message-Id: <1141197929.3866.2.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It seems that I can not get over 3 Gig border, but i need to, to solve
> my numerical problems :(.

get a 64 bit machine...

you can get upto 4Gb if you use a kernel with the 4g/4g patch (which is
mostly old FC2 kernels and RHEL4 kernels at this point, it's a dying
breed)


