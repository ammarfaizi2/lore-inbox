Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271883AbTHDQPG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 12:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271890AbTHDQPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 12:15:06 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:30146 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S271883AbTHDQPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 12:15:02 -0400
X-Sender-Authentification: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Mon, 4 Aug 2003 18:15:00 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Jeff Muizelaar <muizelaar@rogers.com>
Cc: linux-kernel@vger.kernel.org, mru@users.sourceforge.net,
       Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: FS: hardlinks on directories
Message-Id: <20030804181500.074aec51.skraw@ithnet.com>
In-Reply-To: <3F2E7C63.2000203@rogers.com>
References: <20030804141548.5060b9db.skraw@ithnet.com>
	<yw1xsmohioah.fsf@users.sourceforge.net>
	<20030804152226.60204b61.skraw@ithnet.com>
	<3F2E7C63.2000203@rogers.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Aug 2003 11:31:47 -0400
Jeff Muizelaar <muizelaar@rogers.com> wrote:

> Stephan von Krawczynski wrote:
> 
> >
> >I guess this is not really an option if talking about hundreds or thousands
> >of"links", is it?
> >  
> >
> actually hundreds or thounds still should be ok. See...

Hm, and I just found out that re-exporting "mount --bind" volumes does not work
over nfs...

Is this correct, Neil?

Regards,
Stephan

