Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317091AbSG1TFo>; Sun, 28 Jul 2002 15:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317114AbSG1TFo>; Sun, 28 Jul 2002 15:05:44 -0400
Received: from ns.suse.de ([213.95.15.193]:35346 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317091AbSG1TFn>;
	Sun, 28 Jul 2002 15:05:43 -0400
Date: Sun, 28 Jul 2002 21:09:00 +0200
From: Dave Jones <davej@suse.de>
To: Greg KH <greg@kroah.com>
Cc: Tommy Faasen <faasen@xs4all.nl>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] agpgart splitup and cleanup for 2.5.25
Message-ID: <20020728210900.C8720@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Greg KH <greg@kroah.com>, Tommy Faasen <faasen@xs4all.nl>,
	linux-kernel@vger.kernel.org
References: <20020711230222.GA5143@kroah.com> <32918.192.168.0.100.1027865196.squirrel@thuis.zwanebloem.nl> <20020728190049.GA5959@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020728190049.GA5959@kroah.com>; from greg@kroah.com on Sun, Jul 28, 2002 at 12:00:49PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2002 at 12:00:49PM -0700, Greg KH wrote:

 > > I just tried to compile 2.5.29, haven't tried dev kernels since 2.5.24 and
 > > it seems that although the nvidia kernel module builds ok when I try to
 > > start X I get a freeze or a reboot. Any chance it has something to do with
 > > this?
 > 
 > No, I do not.  Without the nvidia kernel module, does everything work
 > just fine?

Given the amount of internal changes since .24 -> .29, I'm not in 
the least surprised that some binary only junk has stopped working.
As usual, the reply AFAICS is "bug nvidia".

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
