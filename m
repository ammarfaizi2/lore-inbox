Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264329AbUD0UW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264329AbUD0UW6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 16:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264330AbUD0UW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 16:22:58 -0400
Received: from sinfonix.rz.tu-clausthal.de ([139.174.2.33]:13495 "EHLO
	sinfonix.rz.tu-clausthal.de") by vger.kernel.org with ESMTP
	id S264329AbUD0UW5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 16:22:57 -0400
From: "Hemmann, Volker Armin" <volker.hemmann@heim9.tu-clausthal.de>
To: "Heilmann, Oliver" <Oliver.Heilmann@drkw.com>
Subject: Re: [PATCH] SIS AGP vs 2.6.6-rc2
Date: Tue, 27 Apr 2004 22:22:39 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, davej@redhat.com,
       oschoett@t-online.de
References: <20040426082159.90513.qmail@web10102.mail.yahoo.com> <200404271929.16786.volker.hemmann@heim9.tu-clausthal.de> <1083094853.7581.14.camel@pandora>
In-Reply-To: <1083094853.7581.14.camel@pandora>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200404272222.39646.volker.hemmann@heim9.tu-clausthal.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I tried the gzip'ed patch and it applied cleanly. 
testgart works and gives the usual results, dmesg is ok, showing the warning.

Nvidia is not working with 2.6.6-rc2, so I do not know exactly that everything 
is ok, but if testgart is fine, X had no problems in the past.

Glück Auf
Volker

-- 
Conclusions
 In a straight-up fight, the Empire squashes the Federation like a bug. Even 
with its numerical advantage removed, the Empire would still squash the 
Federation like a bug. Accept it. -Michael Wong
