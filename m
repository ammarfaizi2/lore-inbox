Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129736AbRCPDSr>; Thu, 15 Mar 2001 22:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129733AbRCPDS2>; Thu, 15 Mar 2001 22:18:28 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:62388 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129725AbRCPDSQ>; Thu, 15 Mar 2001 22:18:16 -0500
Message-ID: <3AB185C1.25865AD6@uow.edu.au>
Date: Fri, 16 Mar 2001 03:17:21 +0000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.4.2-ac19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Shane Y. Gibson" <sgibson@digitalimpact.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Oops 0000 and 0002 on dual PIII 750 2.4.2 SMP platform
In-Reply-To: <3AB13120.AE7187B@digitalimpact.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Shane Y. Gibson" wrote:
> 
> 2.4.2
...
> dual PIII 750s
...
> panicing, and freezing up.


Try using the `nmi_watchdog=0' LILO option.
