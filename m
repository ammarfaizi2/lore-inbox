Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262088AbULMABT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262088AbULMABT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 19:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbULMABT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 19:01:19 -0500
Received: from s1.conecto.pl ([193.29.205.125]:57228 "EHLO s1.conecto.pl")
	by vger.kernel.org with ESMTP id S262088AbULMABS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 19:01:18 -0500
From: Marcin =?iso-8859-2?q?Gibu=B3a?= <mg@iceni.pl>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: STIr4200 warnings
Date: Mon, 13 Dec 2004 01:01:05 +0100
User-Agent: KMail/1.7.1
Cc: Oliver Neukum <oliver@neukum.org>, linux-kernel@vger.kernel.org
References: <200412121153.33981@senat> <200412122309.51065@senat> <41BCCCAA.800@osdl.org>
In-Reply-To: <41BCCCAA.800@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412130101.05722@senat>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm not seeing  a problem with your .config or with mine.
> I'd be suspecting something else, like corrupted tarball
> or not applied correctly, or whatever.

Yes, you were right, it compiles cleanly now.
And 2.6.10-rc3-bk6 fixes the warning.

-- 
mg
