Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262897AbVAKVxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262897AbVAKVxV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 16:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262901AbVAKVxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 16:53:18 -0500
Received: from smtp809.mail.ukl.yahoo.com ([217.12.12.199]:50518 "HELO
	smtp809.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262896AbVAKVvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 16:51:18 -0500
From: Nick Sanders <sandersn@btinternet.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Unable to burn DVDs
Date: Tue, 11 Jan 2005 21:51:13 +0000
User-Agent: KMail/1.7.2
References: <41E2F823.1070608@apartia.fr> <Pine.LNX.4.61.0501112008080.7967@yvahk01.tjqt.qr> <1105474144.15542.1.camel@zeus.city.tvnet.hu>
In-Reply-To: <1105474144.15542.1.camel@zeus.city.tvnet.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501112151.13351.sandersn@btinternet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 11 January 2005 20:09, Sipos Ferenc wrote:
> Hi!
>
> For me, dvd writing works only when I run growisofs with root
> permissions (using 2.6.10 kernel, /dev/hdc without ide-scsi)
>

For me when running growisofs  with user permissions on 2.6.10 (ide-cd) it 
works perfectly 1st time but 2nd time fails with the error below. It works 
fine when run as root.

:-( unable to PREVENT MEDIA REMOVAL: Operation not permitted

As an aside audio cd burning with cdrecord works as long as the '-text' option 
isn't used, if it is the process hangs.

Nick
