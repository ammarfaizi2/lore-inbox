Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265534AbRF2Dm1>; Thu, 28 Jun 2001 23:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265530AbRF2DmQ>; Thu, 28 Jun 2001 23:42:16 -0400
Received: from paloma13.e0k.nbg-hannover.de ([62.159.219.13]:62955 "HELO
	paloma13.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S265518AbRF2DmK>; Thu, 28 Jun 2001 23:42:10 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Alan Cox <alan@redhat.com>
Subject: Re: Linux 2.4.5-ac21
Date: Fri, 29 Jun 2001 05:41:43 +0200
X-Mailer: KMail [version 1.2.2]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20010629034213Z265518-17720+8937@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 29. Juni 2001 03:59 schrieb Dieter Nützel:
> Hello Alan,
>
> you've missed the CONFIG_DRM_AGP thing.
> Some other config objects (Input -> joysticks , SMB file system) are
> broken, too.

Keith Owens patch fixed it of course.
http://marc.theaimsgroup.com/?l=linux-kernel&m=99378430115592&w=2

Thanks Keith!

-Dieter
