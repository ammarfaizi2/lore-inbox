Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbVHHSdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbVHHSdY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 14:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbVHHSdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 14:33:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39141 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932170AbVHHSdW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 14:33:22 -0400
Date: Mon, 8 Aug 2005 14:33:00 -0400
From: Dave Jones <davej@redhat.com>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rolf Eike Beer <eike-kernel@sf-tec.de>
Subject: Re: [PATCH] Removing maintainer's bad e-mails
Message-ID: <20050808183300.GB26182@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jiri Slaby <jirislaby@gmail.com>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Rolf Eike Beer <eike-kernel@sf-tec.de>
References: <42F69E53.40602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42F69E53.40602@gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2005 at 01:50:43AM +0200, Jiri Slaby wrote:

 > diff --git a/MAINTAINERS b/MAINTAINERS
 > --- a/MAINTAINERS
 > +++ b/MAINTAINERS
 > @@ -204,8 +204,6 @@ S:	Maintained
 > 
 > ADVANSYS SCSI DRIVER
 > P:	Bob Frey
 > -M:	linux@advansys.com
 > -W:	http://www.advansys.com/linux.html
 > L:	linux-scsi@vger.kernel.org
 > S:	Maintained

You may as well change the S: to unmaintained whilst
you're there, it hasn't seen any updates in a long time,
and still uses several out-of-date SCSI APIs.

		Dave

