Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315709AbSENNVB>; Tue, 14 May 2002 09:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315711AbSENNVA>; Tue, 14 May 2002 09:21:00 -0400
Received: from itnoc4.toshiba-it.co.jp ([210.254.22.247]:63895 "EHLO
	itnoc4.toshiba-it.co.jp") by vger.kernel.org with ESMTP
	id <S315709AbSENNU7>; Tue, 14 May 2002 09:20:59 -0400
Date: Tue, 14 May 2002 22:20:24 +0900
From: Masaru Kawashima <masaruk@gol.com>
To: Marc-Christian Petersen <mcp@linux-systeme.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vmwarefb 0.5.0
Message-Id: <20020514222024.4b18a826.masaruk@gol.com>
In-Reply-To: <200205141048.12576.mcp@linux-systeme.de>
X-Mailer: Sylpheed version 0.7.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ITENET2/toshiba-it(Release 5.0.8 |June 18, 2001) at
 2002/05/14 10:20:42 PM,
	Serialize by Router on ITENET2/toshiba-it(Release 5.0.8 |June 18, 2001) at
 2002/05/14 10:20:43 PM,
	Serialize complete at 2002/05/14 10:20:43 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 14 May 2002 10:48:12 +0200
Marc-Christian Petersen <mcp@linux-systeme.de> wrote:

> Hi Denis,
> 
> 
> diff -uraN linux-2.4.19-pre8/include/linux/fb.h linux/include/linux/fb.h
> --- linux-2.4.19-pre8/include/linux/fb.h	Tue May 14 05:11:14 2002
> +++ linux/include/linux/fb.h	Tue May 14 01:24:06 2002
> @@ -96,6 +96,8 @@
>  #define FB_ACCEL_3DLABS_PERMEDIA3 37	/* 3Dlabs Permedia 3		*/
>  #define FB_ACCEL_ATI_RADEON	38	/* ATI Radeon family		*/
>  
> +#define FB_ACCEL_VMWARE_SVGA	50	/* VMware Virtual SVGA Graphics */
> +#define FB_ACCE
> ^ ^ ^ Where is the rest? :) Looks like incomplete. Or is it only one add?

Take a look at following URLs.
  http://marc.theaimsgroup.com/?l=linux-kernel&m=102134726119425&w=2
  http://marc.theaimsgroup.com/?l=linux-kernel&m=102134726119425&q=p3


-- 
Masaru Kawashima <masaruk@gol.com>
