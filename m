Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129660AbRBRUgY>; Sun, 18 Feb 2001 15:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129867AbRBRUgO>; Sun, 18 Feb 2001 15:36:14 -0500
Received: from tomts8.bellnexxia.net ([209.226.175.52]:35264 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S129660AbRBRUgD>; Sun, 18 Feb 2001 15:36:03 -0500
Message-ID: <3A903159.3D190848@sympatico.ca>
Date: Sun, 18 Feb 2001 15:32:25 -0500
From: Jeremy Jackson <jeremy.jackson@sympatico.ca>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Scott Long <smlong@teleport.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux OS boilerplate
In-Reply-To: <3A902F77.8BF6AB52@teleport.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scott Long wrote:

> Does there exist an outline (detailed or not) of the boot process from
> the point of BIOS bootsector load to when the kernel proper begins
> execution? If not would anyone be willing to help me understand
> bootsect.S and setup.S enough so that I might write such an outline?

I have been over it, and would be willing to help.  You should first read all

of the LILO documentation, and check out some of the LinuxBIOS
project at www.linuxbios.org.

