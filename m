Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267120AbTBXOQd>; Mon, 24 Feb 2003 09:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267125AbTBXOQd>; Mon, 24 Feb 2003 09:16:33 -0500
Received: from mail.ithnet.com ([217.64.64.8]:11018 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S267120AbTBXOQc>;
	Mon, 24 Feb 2003 09:16:32 -0500
Date: Mon, 24 Feb 2003 15:26:30 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Problem with IDE-SCSI in 2.4.21-pre4/2.4.20
Message-Id: <20030224152630.02ee680c.skraw@ithnet.com>
In-Reply-To: <20030224141433.GE27646@louise.pinerecords.com>
References: <20030224122259.7a468c82.skraw@ithnet.com>
	<20030224113002.GC27646@louise.pinerecords.com>
	<20030224132909.068d0ce9.skraw@ithnet.com>
	<20030224124317.GD27646@louise.pinerecords.com>
	<20030224150413.3beca89a.skraw@ithnet.com>
	<20030224141433.GE27646@louise.pinerecords.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Feb 2003 15:14:33 +0100
Tomas Szepe <szepe@pinerecords.com> wrote:

> > [skraw@ithnet.com]
> > 
> > > Serverworks.  Well, you definitely want to try -ac.  :)
> > 
> > I just tried -ac6, but has the same problem.
> 
> Another entry for Alan's IDE buglist then.
> He's quite sure to pick up your bugreport, thanks.

I am not all that sure, that it's a simple IDE problem. If it were I would
expect booting (and using) a linux live filesystems not to work. But that does
indeed work. There seems to be a problem around the ide-scsi stuff. If I can
try any patches of interest I will. If I can put in some debugging printk I can
do that, too. But as I don't know what is especially known-to-be-fishy around
ide-scsi I have no good idea where to start ...

-- 
Regards,
Stephan

