Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262290AbTGOFMa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 01:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbTGOFMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 01:12:30 -0400
Received: from almesberger.net ([63.105.73.239]:25103 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S262290AbTGOFM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 01:12:28 -0400
Date: Tue, 15 Jul 2003 02:27:11 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Deepak Saxena <dsaxena@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Alan Shih: "TCP IP Offloading Interface"
Message-ID: <20030715022711.A5608@almesberger.net>
References: <Sea2-F18ekWo76UaiRN00008964@hotmail.com> <3F12FE4B.2070004@pobox.com> <20030714212222.GA21569@xanadu.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030714212222.GA21569@xanadu.az.mvista.com>; from dsaxena@mvista.com on Mon, Jul 14, 2003 at 02:22:22PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Deepak Saxena wrote:
> My question back is how do you evaluate a high-end SCSI RAID controller
> to make sure that there is no bug in the firmware that causes you to loose 
> all your data?

This may be a great moment for relaxing with a good book, e.g. Bruce
Schneier's "Secrets & Lies", chapter 22, where he describes why
functional testing and discovering security bugs are so different.

> Finally, I would like to point out that just b/c something is considered
> bad does not preclude it from being in the kernel.

Well, in the case of TOE, we should at least be able to politely ask
all the useless silicon to step aside :-)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
