Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288671AbSAQNOC>; Thu, 17 Jan 2002 08:14:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288675AbSAQNNw>; Thu, 17 Jan 2002 08:13:52 -0500
Received: from smtp-out.hamburg.pop.de ([195.222.210.86]:25356 "EHLO
	smtp-out.hamburg.pop.de") by vger.kernel.org with ESMTP
	id <S288671AbSAQNNg> convert rfc822-to-8bit; Thu, 17 Jan 2002 08:13:36 -0500
Subject: Re: problem: devfs scsi tape permissions
From: Michael Reincke <reincke.m@stn-atlas.de>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20010808072147.00943ce9.reincke.m@stn-atlas.de>
In-Reply-To: <20010808072147.00943ce9.reincke.m@stn-atlas.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/1.0.1 
Date: 17 Jan 2002 14:13:33 +0100
Message-Id: <1011273214.3068.10.camel@pcew80>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-01-17 at 13:54, Michael Reincke wrote:
> Hi,
> 
> i've some trouble with devfs and the permission on my SCSI-tape drive:
> 
> after a reboot the permissions on /dev/scsi/host0/bus0/target4/lun0 are as
> follows
> drwxr-xr-x    1 root     root            0 Jan  1  1970 lun0/
> 
> A request on the tape-drive as normal user gives a permission denied and
> the permissions on /dev/scsi/host0/bus0/target4/lun0  set to 
> drw-------    1 root     root            0 Jan  1  1970 lun0/

Please ignore the previous mail. It's my fault.


-- 
Michael Reincke, NUT Team 2 (Software Build Management)

STN ATLAS Elektronik GmbH, Bremen (Germany)
E-mail : reincke.m@stn-atlas.de |  mail: Sebaldsbrücker Heerstr 235    
phone  : +49-421-457-2302       |        28305 Bremen                  
fax    : +49-421-457-3913       |


