Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261370AbTAOFYI>; Wed, 15 Jan 2003 00:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261371AbTAOFYI>; Wed, 15 Jan 2003 00:24:08 -0500
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:41091 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S261370AbTAOFYI>; Wed, 15 Jan 2003 00:24:08 -0500
From: "Ivan G." <ivangurdiev@attbi.com>
Reply-To: ivangurdiev@attbi.com
Organization: ( )
To: Patrick Mochel <mochel@osdl.org>
Subject: Re: 2.5.58 Oops when booting from initrd - kobject_del
Date: Tue, 14 Jan 2003 22:32:53 -0700
User-Agent: KMail/1.5
References: <Pine.LNX.4.33.0301141552130.1025-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.33.0301141552130.1025-100000@localhost.localdomain>
Cc: <Valdis.Kletnieks@vt.edu>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200301142232.54257.ivangurdiev@attbi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Could you please try the following patch and see if it fixes the problem?

That fixes it for me.
Thanks.

