Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261895AbSI3Bfd>; Sun, 29 Sep 2002 21:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261896AbSI3Bfd>; Sun, 29 Sep 2002 21:35:33 -0400
Received: from mx11.dmz.fedex.com ([199.81.193.118]:20487 "EHLO
	mx11.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S261895AbSI3Bfd>; Sun, 29 Sep 2002 21:35:33 -0400
Date: Mon, 30 Sep 2002 09:39:51 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: omit_ECE <omit@rice.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: linux-kernel@vger.kernel.org
In-Reply-To: <00d601c2681e$a60c3280$7f71a018@OMIT>
Message-ID: <Pine.LNX.4.44.0209300939270.13569-100000@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 09/30/2002
 09:40:51 AM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 09/30/2002
 09:40:53 AM,
	Serialize complete at 09/30/2002 09:40:53 AM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Sep 2002, omit_ECE wrote:
>
> Aren't "printf" and "fprintf"  standard outputs? I also put #include <stdio.h>
> and "FILE *in_file", but they didn't work. Please give me suggestions.

try printk instead.

Jeff


