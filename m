Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264469AbTEaVuh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 17:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264471AbTEaVuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 17:50:37 -0400
Received: from ip67-95-245-82.z245-95-67.customer.algx.net ([67.95.245.82]:35333
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S264469AbTEaVug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 17:50:36 -0400
Date: Sat, 31 May 2003 14:56:38 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Byron Stanoszek <gandalf@winds.org>
Cc: Alexandre Pereira Nunes <alex@PolesApart.wox.org>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.21-rc6 ide-scsi bug?
Message-ID: <20030531215638.GC25810@matchmail.com>
Mail-Followup-To: Byron Stanoszek <gandalf@winds.org>,
	Alexandre Pereira Nunes <alex@PolesApart.wox.org>,
	linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <3ED8CA77.9030809@PolesApart.wox.org> <Pine.LNX.4.44.0305311552460.5395-100000@winds.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305311552460.5395-100000@winds.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 31, 2003 at 03:57:11PM -0400, Byron Stanoszek wrote:
> I'm currently using 2.4.20-pre5-ac1 with Andre Hedrick's IDE Patch applied. So,

Do you need this patch?  Why isn't Alan's code enough?

If Andre isn't sending his patches or Alan hasn't integrated them then maybe
Alan has some plans for it.

Also, maybe the patch is incompatible with the latest -ac?
