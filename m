Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264557AbUAFQfN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 11:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264563AbUAFQe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 11:34:26 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:26315 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S264557AbUAFQdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 11:33:43 -0500
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH] libata update
References: <200401041413.20573.marchand@kde.org> <3FFA80BE.2040205@pobox.com>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 06 Jan 2004 08:33:39 -0800
In-Reply-To: <3FFA80BE.2040205@pobox.com>
Message-ID: <52ekudvxy4.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 06 Jan 2004 16:33:41.0419 (UTC) FILETIME=[D8254FB0:01C3D472]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff and others,

On the topic of Silicon Image SATA support, how do things look for
supporting the SiI 3512?  This chip seems to be pretty common on
Nforce3 boards.

I had a look on the SiI web site and they say the programming
interface is very close to the 3112.  Unfortunately their data sheets
don't seem to be freely available so I can't tell how close the
interface really is (or do the work to add 3512 support myself).

Thanks,
  Roland
