Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750953AbWC0QKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbWC0QKt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 11:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbWC0QKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 11:10:49 -0500
Received: from compunauta.com ([69.36.170.169]:24234 "EHLO compunauta.com")
	by vger.kernel.org with ESMTP id S1750948AbWC0QKs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 11:10:48 -0500
From: Gustavo Guillermo =?iso-8859-1?q?P=E9rez?= 
	<gustavo@compunauta.com>
Organization: www.compunauta.com
To: Chris Boot <bootc@bootc.net>
Subject: Re: amdtp driver removed? wich should be handle FireWire CDROM cases?
Date: Mon, 27 Mar 2006 10:10:43 -0600
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <200603261558.27583.gustavo@compunauta.com> <44279943.9000207@bootc.net>
In-Reply-To: <44279943.9000207@bootc.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200603271010.43931.gustavo@compunauta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Seeing the changelog I realized the amdtp driver I was being used to
> > handle a Firewire External HD/CD case was removed.
> >
> > Is there any replacement or the driver is unmantained?.
>
> Shouldn't it just work with sbp2?
Yes, sorry.
my mistake.
-- 
Gustavo Guillermo Pérez
Compunauta uLinux
www.compunauta.com
