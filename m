Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268682AbTGOQWg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 12:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268727AbTGOQWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 12:22:36 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:9159
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S268682AbTGOQWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 12:22:34 -0400
Subject: Re: Remove net drivers depending on OBSOLETE
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: jgarzik@pobox.com, akpm@digeo.com, linux-net@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030713222945.GC12104@fs.tum.de>
References: <20030713222945.GC12104@fs.tum.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058286825.3845.41.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 15 Jul 2003 17:33:45 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-07-13 at 23:29, Adrian Bunk wrote:
> The following three net drivers depend in both 2.4 and 2.5 on 
> CONFIG_OBSOLETE:
> - FMV18X

Seems to be a mirror of the at1700 driver. Does anyone know if both do
the same hardware ?
> - SEEQ8005
Fixed

