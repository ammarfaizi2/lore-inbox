Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751782AbWBMOKO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751782AbWBMOKO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 09:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751783AbWBMOKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 09:10:14 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:35857 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1751781AbWBMOKM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 09:10:12 -0500
Date: Mon, 13 Feb 2006 15:10:11 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: max symlink = 5? ?bug? ?feature deficit?
Message-ID: <20060213141011.GB59213@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Willy Tarreau <willy@w.ods.org>,
	Linux-Kernel <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
References: <43ED5A7B.7040908@tlinx.org> <20060212180601.GU27946@ftp.linux.org.uk> <43EFA63B.30907@tlinx.org> <20060212212504.GX27946@ftp.linux.org.uk> <43EFBCA9.1090501@tlinx.org> <20060213000803.GY27946@ftp.linux.org.uk> <43EFD8BF.1040205@tlinx.org> <20060213073746.GG11380@w.ods.org> <1139816896.2997.19.camel@laptopd505.fenrus.org> <20060213080331.GH11380@w.ods.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060213080331.GH11380@w.ods.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2006 at 09:03:31AM +0100, Willy Tarreau wrote:
> That's how I understood it, but I only thought about easy cases. Now,
> I can imagine cross-FS links and I don't see an easy way to resolve
> them :-/

And don't forget automount points too...

  OG.
