Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264478AbTFYKiA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 06:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264472AbTFYKhB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 06:37:01 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:49670 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id S264478AbTFYKfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 06:35:24 -0400
Date: Wed, 25 Jun 2003 12:48:43 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Stewart Smith <stewart@linux.org.au>
cc: trivial@rustcorp.com.au, <linux-kernel@vger.kernel.org>
Subject: Re: [trivial 2.5] kconfig language doc r.e. --help--
In-Reply-To: <20030625084309.GA9295@cancer>
Message-ID: <Pine.LNX.4.44.0306251246240.11817-100000@serv>
References: <20030625084309.GA9295@cancer>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 25 Jun 2003, Stewart Smith wrote:

> --- linux-2.5.73/Documentation/kbuild/kconfig-language.txt	2003-06-15 17:47:18.000000000 +1000
> +++ linux-2.5.73-stew1/Documentation/kbuild/kconfig-language.txt	2003-06-25 18:38:49.000000000 +1000
> @@ -109,6 +109,8 @@
>    This defines a help text. The end of the help text is determined by
>    the indentation level, this means it ends at the first line which has
>    a smaller indentation than the first line of the help text.
> +  You may also use dashes around the word help to assist in the visual
> +  separation of help from configuration. e.g. '--help--' or '---help---'.
> +  These dashes have no effect on functionality, they are purely decorative.

Where did you find the '--help--' version? I'm actually suprised that 
works. The official alternative is only '---help---'.

bye, Roman

