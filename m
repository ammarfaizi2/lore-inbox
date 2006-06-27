Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932340AbWF0MQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbWF0MQx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 08:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbWF0MQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 08:16:52 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:7827 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S932335AbWF0MQv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 08:16:51 -0400
Date: Tue, 27 Jun 2006 14:16:49 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: lib(p)ata SMART support?
Message-ID: <20060627121649.GL3114@harddisk-recovery.com>
References: <200606271555.13330.arvidjaar@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606271555.13330.arvidjaar@mail.ru>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2006 at 03:55:12PM +0400, Andrey Borzenkov wrote:
> Using legacy drivers I can use any SMART tools out there; HDD does support 
> SMART. Running libata + pata_ali, smartctl claims device does not support 
> SMART. This is sort of regression when switching from legacy drivers.

Try smartctl -d ata.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
