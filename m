Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277252AbRJIOZ4>; Tue, 9 Oct 2001 10:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277255AbRJIOZi>; Tue, 9 Oct 2001 10:25:38 -0400
Received: from barn.holstein.com ([198.134.143.193]:43526 "EHLO holstein.com")
	by vger.kernel.org with ESMTP id <S277252AbRJIOZ1>;
	Tue, 9 Oct 2001 10:25:27 -0400
Date: Tue, 9 Oct 2001 09:42:15 -0400
Message-Id: <200110091342.f99DgFK02306@pcx4168.holstein.com>
From: "Todd M. Roy" <troy@holstein.com>
To: kaos@ocs.com.au
Cc: todd_m_roy@yahoo.com, linux-kernel@vger.kernel.org
In-Reply-To: <27179.1002601458@kao2.melbourne.sgi.com> (message from Keith
	Owens on Tue, 09 Oct 2001 14:24:18 +1000)
Subject: Re: jbd_preclean_buffer_check.
Reply-To: troy@holstein.com
In-Reply-To: <27179.1002601458@kao2.melbourne.sgi.com>
X-MIMETrack: Itemize by SMTP Server on Imail/Holstein(Release 5.0.1b|September 30, 1999) at
 10/09/2001 10:24:53 AM,
	Serialize by Router on Imail/Holstein(Release 5.0.1b|September 30, 1999) at
 10/09/2001 10:24:54 AM,
	Serialize complete at 10/09/2001 10:24:54 AM
X-Priority: 3 (Normal)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yup.  Thanks a lot.  Sorry to waste your time.

-- todd --

>  X-Apparently-To: todd_m_roy@yahoo.com via web13603.mail.yahoo.com; 08 Oct 2001 21:24:27 -0700 (PDT)
>  X-Track: 1: 40
>  From: Keith Owens <kaos@ocs.com.au>
>  Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
>     Andrew Morton <andrewm@uow.edu.au>
>  Content-Type: text/plain; charset=us-ascii
>  Date: Tue, 09 Oct 2001 14:24:18 +1000
>  
>  On Mon, 8 Oct 2001 21:05:51 -0700 (PDT), 
>  Todd Roy <todd_m_roy@yahoo.com> wrote:
>  >Sorry if this is old guys, but I just noticed
>  >that modules loop.o and md.o are broken in at least
>  >2.4.10-ac9
>  >and ac10, if  CONFIG_EXT3_FS=Y, JBD_CONFIG=Y and
>  >CONFIG_JBD_DEBUG=Y:
>  >
>  >typical modprobe output:
>  >/lib/modules/2.4.10-ac10/kernel/drivers/md/md.o:
>  >unresolved symbol jbd_preclean_buffer_check
>  
>  Work for me.  Did you get bitten by http://www.tux.org/lkml/#s8-8?  If
>  that does not fix it, I need your complete .config plus your
>  /proc/ksyms.
>  


**********************************************************************
This footnote confirms that this email message has been swept by 
MIMEsweeper for the presence of computer viruses.
**********************************************************************
