Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271439AbTGQLzU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 07:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271440AbTGQLzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 07:55:19 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:63726 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S271439AbTGQLzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 07:55:10 -0400
Subject: Re: devfsd/2.6.0-test1
From: Martin Schlemmer <azarah@gentoo.org>
To: Mark Watts <m.watts@eris.qinetiq.com>
Cc: KML <linux-kernel@vger.kernel.org>
In-Reply-To: <200307171017.56778.m.watts@eris.qinetiq.com>
References: <200307171017.56778.m.watts@eris.qinetiq.com>
Content-Type: text/plain
Organization: 
Message-Id: <1058443807.13515.1530.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 17 Jul 2003 14:10:08 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-07-17 at 11:17, Mark Watts wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> 
> I'm running devfs on a 2.6.0-test1 box (Mandrake 9.1 with the new kernel)
> 
> Every time I boot, it complains that I don't have an /etc/modprobe.devfs.
> If I symlink modules.devfs, I get a wad of errors about 'probeall'.
> What should a modprobe.devfs look like for a 2.5/6 kernel?
> 

The module-init-tools tarball should include one.


Regards,

-- 
Martin Schlemmer


