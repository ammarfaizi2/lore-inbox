Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbTI3Lyt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 07:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbTI3Lyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 07:54:49 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:35535 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261357AbTI3Lyr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 07:54:47 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Andreas Jellinghaus <aj@dungeon.inka.de>
Subject: Re: ide problem in newer kernel or disc failure
Date: Tue, 30 Sep 2003 13:57:15 +0200
User-Agent: KMail/1.5.4
References: <1064881613.811.8.camel@simulacron>
In-Reply-To: <1064881613.811.8.camel@simulacron>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309301357.15548.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 30 of September 2003 02:26, Andreas Jellinghaus wrote:
> Hi,
>
> my disc starts showing problems. a few weeks ago it was fine.
> could that be a problem with latest 2.6.0-test* kernels
> or is my disc failing?

<...>

Looks like a failing disk (errors logged by SMART).

--bartlomiej

