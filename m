Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933049AbWKNHmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933049AbWKNHmk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 02:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933050AbWKNHmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 02:42:40 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:27305 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S933049AbWKNHmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 02:42:39 -0500
Subject: Re: [PATCH 0/2] Make the TSC safe to be used by gettimeofday().
From: Arjan van de Ven <arjan@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: Suleiman Souhlal <ssouhlal@freebsd.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>, vojtech@suse.cz,
       Jiri Bohac <jbohac@suse.cz>
In-Reply-To: <200611140250.57160.ak@suse.de>
References: <455916A5.2030402@FreeBSD.org>  <200611140250.57160.ak@suse.de>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 14 Nov 2006 08:42:33 +0100
Message-Id: <1163490154.15249.235.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-14 at 02:50 +0100, Andi Kleen wrote:
> On Tuesday 14 November 2006 02:06, Suleiman Souhlal wrote:
> > I've had a proof-of-concept for this since August, and finally got around to
> > somewhat cleaning it up.
> 
> Thanks. 
> 
> I got a competing implementation for this unfortunately now from Vojtech & Jiri


where is this posted?
Since last weeks discussion on tickless several people started
implementing alternatives since nothing existed in public ...


