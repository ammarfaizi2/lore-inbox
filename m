Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288736AbSBKMJc>; Mon, 11 Feb 2002 07:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288952AbSBKMJW>; Mon, 11 Feb 2002 07:09:22 -0500
Received: from cobae1.consultronics.on.ca ([205.210.130.26]:5512 "EHLO
	cobae1.consultronics.on.ca") by vger.kernel.org with ESMTP
	id <S288736AbSBKMJC>; Mon, 11 Feb 2002 07:09:02 -0500
Date: Mon, 11 Feb 2002 07:08:58 -0500
From: Greg Louis <glouis@dynamicro.on.ca>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        LKML <linux-kernel@vger.kernel.org>, dz@debian.org
Subject: Resolved: APM fix from -pre7 seems to break "Dell laptop support"
Message-ID: <20020211120857.GA1505@athame.dynamicro.on.ca>
Reply-To: Greg Louis <glouis@dynamicro.on.ca>
Mail-Followup-To: Marcelo Tosatti <marcelo@conectiva.com.br>,
	LKML <linux-kernel@vger.kernel.org>, dz@debian.org
In-Reply-To: <Pine.LNX.4.21.0202041743180.14205-100000@freak.distro.conectiva> <20020210130447.GA1001@athame.dynamicro.on.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20020210130447.GA1001@athame.dynamicro.on.ca>
Organization: Dynamicro Consulting Limited
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20020210 (Sun) at 0804:47 -0500, Greg Louis wrote:
> With CONFIG_I8K=y and Massimo Dal Zotto's i8k utilities, it's necessary
> for me to revert Stephen Rothwell's 2.4.17-APM.1 patch that went into
> 18-pre7.  If I don't, CPU temperature readings jump around erratically
> and the fans come on at the wrong temperatures.

After some offlist correspondence, Massimo has released version 1.10 of
his utilities, and this new version is working fine for me with
Stephen's APM changes in the kernel.  Thanks to both Massimo and Alan
Cox for their help!

-- 
| G r e g  L o u i s          | gpg public key:      |
|   http://www.bgl.nu/~glouis |   finger greg@bgl.nu |
