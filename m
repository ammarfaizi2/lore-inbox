Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264514AbTEaXwY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 19:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264515AbTEaXwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 19:52:24 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:55265
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264514AbTEaXwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 19:52:23 -0400
Subject: Re: 2.4.21-rc6 ide-scsi bug?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Byron Stanoszek <gandalf@winds.org>
Cc: Mike Fedyk <mfedyk@matchmail.com>,
       Alexandre Pereira Nunes <alex@PolesApart.wox.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0305311858370.5395-100000@winds.org>
References: <Pine.LNX.4.44.0305311858370.5395-100000@winds.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054422394.28853.2.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 01 Jun 2003 00:06:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-06-01 at 00:00, Byron Stanoszek wrote:
> I recommend sticking with the latest -ac version regardless. :) It has most of
> Andre's patches in anyway, with everything else fixed--except for this one
> problem.

To do anything about it I need a call trace, that means causing the crash in console
mode I suspect

