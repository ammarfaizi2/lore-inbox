Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265970AbUHCPD2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265970AbUHCPD2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 11:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266558AbUHCPD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 11:03:28 -0400
Received: from smtp9.wanadoo.fr ([193.252.22.22]:43831 "EHLO
	mwinf0903.wanadoo.fr") by vger.kernel.org with ESMTP
	id S265970AbUHCPD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 11:03:27 -0400
From: Waldo Bastian <bastian@kde.org>
To: kde@mail.kde.org, gene.heskett@verizon.net
Subject: Re: [kde] kde problem... Or kernel?
Date: Tue, 3 Aug 2004 17:21:16 +0200
User-Agent: KMail/1.6.82
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
References: <200408031057.14453.gene.heskett@verizon.net>
In-Reply-To: <200408031057.14453.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408031721.16319.bastian@kde.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 August 2004 16:57, Gene Heskett wrote:
> Greetings;
>
> kernel 2.6.8-rc2-mm2, kde3.3-beta2.
>
> Now that it appears I'm stable again, I am asking if the memory data
> that kpm and ksysguard use has been moved recently?
>
> Both utils are now showing long strings of 8888888888 in the bottom
> lines of their windows now, for everything thats normally there.

It's a KDE bug. kpm and ksysguard share the same code base.

Cheers,
Waldo
-- 
bastian@kde.org  |   KDE Community World Summit 2004  |  bastian@suse.com
bastian@kde.org  | 21-29 August, Ludwigsburg, Germany |  bastian@suse.com
