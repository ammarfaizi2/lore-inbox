Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267148AbRGPAha>; Sun, 15 Jul 2001 20:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267151AbRGPAhU>; Sun, 15 Jul 2001 20:37:20 -0400
Received: from flodhest.stud.ntnu.no ([129.241.56.24]:45507 "EHLO
	flodhest.stud.ntnu.no") by vger.kernel.org with ESMTP
	id <S267148AbRGPAhE>; Sun, 15 Jul 2001 20:37:04 -0400
Date: Mon, 16 Jul 2001 02:37:03 +0200
From: =?iso-8859-1?Q?Thomas_Lang=E5s?= <tlan@stud.ntnu.no>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: tlan@stud.ntnu.no, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make SCSI-system aware of type 12-devices
Message-ID: <20010716023703.A27290@flodhest.stud.ntnu.no>
Reply-To: tlan@stud.ntnu.no
In-Reply-To: <mailman.995240941.28583.linux-kernel2news@redhat.com> <200107160015.f6G0F9W01045@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200107160015.f6G0F9W01045@devserv.devel.redhat.com>; from zaitcev@redhat.com on Sun, Jul 15, 2001 at 08:15:09PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev:
> Yeah, however nobody tried to implement SCC command class before.
> It is much easier for a controller vendor to provide REPORT_LUNS
> (which is enough to find volumes), and have some out-of-band
> management interface - front panel, telnet, or a web form.

This controller has a consolle which you can hook up to, to do management.

> Out of curiousity, what is your hardware?

Compaq StorageWorks (announced vendor is DEC, tho) HSG80.

-- 
-Thomas
