Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751245AbWBZPwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbWBZPwi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 10:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbWBZPwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 10:52:38 -0500
Received: from ns.firmix.at ([62.141.48.66]:10912 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S1751245AbWBZPwh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 10:52:37 -0500
Subject: Re: [slightly OT] dvdrecord 0.3.1 -- and yes, dev=/dev/cdrom works
	;)
From: Bernd Petrovitsch <bernd@firmix.at>
To: Luke-Jr <luke@dashjr.org>
Cc: Jesper Juhl <jesper.juhl@gmail.com>,
       Bernhard Rosenkraenzer <bero@arklinux.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200602261339.13821.luke@dashjr.org>
References: <200602250042.51677.bero@arklinux.org>
	 <200602261330.15709.luke@dashjr.org>
	 <9a8748490602260529h3a2890bhce4112feefb7cb1f@mail.gmail.com>
	 <200602261339.13821.luke@dashjr.org>
Content-Type: text/plain
Organization: http://www.firmix.at/
Date: Sun, 26 Feb 2006 16:50:31 +0100
Message-Id: <1140969031.3510.37.camel@gimli.at.home>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-02-26 at 13:39 +0000, Luke-Jr wrote:
[...]
> My [limited] understanding of DVD-RAM drives was that they are basically 
> removable block devices... you wouldn't need a recording program for that, 
> you'd use it like a floppy.

Yes, that's basically the case.
However one uses usually[0] UDF as filesystem.

	Bernd

[0]: You can use ext2 or others too, but then you can't read it on other
     OSes withour support for such filesystems.
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services



