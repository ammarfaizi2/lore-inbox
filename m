Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271374AbTGQKHU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 06:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271377AbTGQKHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 06:07:19 -0400
Received: from office.mandrakesoft.com ([195.68.114.34]:11763 "EHLO
	vador.mandrakesoft.com") by vger.kernel.org with ESMTP
	id S271374AbTGQKHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 06:07:19 -0400
To: Mark Watts <m.watts@eris.qinetiq.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: devfsd/2.6.0-test1
X-URL: <http://www.linux-mandrake.com/
References: <200307171017.56778.m.watts@eris.qinetiq.com>
From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Organization: MandrakeSoft
Date: Thu, 17 Jul 2003 12:02:13 +0200
In-Reply-To: <200307171017.56778.m.watts@eris.qinetiq.com> (Mark Watts's
 message of "Thu, 17 Jul 2003 10:17:56 +0100")
Message-ID: <m265m1fp3u.fsf@vador.mandrakesoft.com>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Watts <m.watts@eris.qinetiq.com> writes:

> I'm running devfs on a 2.6.0-test1 box (Mandrake 9.1 with the new
> kernel)
> 
> Every time I boot, it complains that I don't have an
> /etc/modprobe.devfs.  If I symlink modules.devfs, I get a wad of
> errors about 'probeall'.  What should a modprobe.devfs look like for
> a 2.5/6 kernel?

tv@vador ~ $ urpmf /etc/modprobe.devfs
module-init-tools:/etc/modprobe.devfs

