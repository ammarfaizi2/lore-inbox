Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318142AbSGMKpy>; Sat, 13 Jul 2002 06:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318143AbSGMKpx>; Sat, 13 Jul 2002 06:45:53 -0400
Received: from velli.mail.jippii.net ([195.197.172.114]:33988 "HELO
	velli.mail.jippii.net") by vger.kernel.org with SMTP
	id <S318142AbSGMKpx>; Sat, 13 Jul 2002 06:45:53 -0400
Date: Sat, 13 Jul 2002 13:52:17 +0300
From: Anssi Saari <as@sci.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
Message-ID: <20020713105217.GB11996@sci.fi>
Mail-Followup-To: Anssi Saari <as@sci.fi>,
	linux-kernel@vger.kernel.org
References: <200207121955.g6CJtQur018433@burner.fokus.gmd.de> <20020713054058.GA19292@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020713054058.GA19292@codepoet.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2002 at 11:40:58PM -0600, Erik Andersen wrote:
> Yes, I have read the cdrecord source.  As you may recall from the
> bug reports I would send periodically, I maintained the Debian
> cdrecord/cdrtools package from 1998 till late last year...

> Ever look at the CDROM_SEND_PACKET ioctl?

Support for that appeared in cdrecord some time ago. From what little I've
used it, it seems to work fine even though Joerg calls it pre-alpha code.
