Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264604AbTLEXeX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 18:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264830AbTLEXeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 18:34:22 -0500
Received: from fep01-0.kolumbus.fi ([193.229.0.41]:15966 "EHLO
	fep01-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S264604AbTLEXeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 18:34:21 -0500
Date: Sat, 6 Dec 2003 01:33:29 +0200 (MET DST)
From: Szakacsits Szabolcs <szaka@sienet.hu>
X-X-Sender: szaka@ua178d119.elisa.omakaista.fi
To: Mike Fedyk <mfedyk@matchmail.com>
cc: M?ns Rullg?rd <mru@kth.se>, linux-kernel@vger.kernel.org
Subject: Re: Is there a "make hole" (truncate in middle) syscall?
In-Reply-To: <20031205224142.GR29119@mis-mike-wstn.matchmail.com>
Message-ID: <Pine.LNX.4.58.0312060126510.9180@ua178d119.elisa.omakaista.fi>
References: <200312041432.23907.rob@landley.net>
 <Pine.LNX.4.58.0312042300550.2330@ua178d119.elisa.omakaista.fi>
 <yw1xllprihwo.fsf@kth.se> <20031205224142.GR29119@mis-mike-wstn.matchmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 5 Dec 2003, Mike Fedyk wrote:

> So with this, you can create sparse files for an entire set of files by just
> cping them? :)

You can create sparse file even from stdin with cp. I wrote about here
(handling sparse files section), 
http://linux-ntfs.sourceforge.net/man/ntfsclone.html

	Szaka
