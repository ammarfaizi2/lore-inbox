Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbTHSVxt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 17:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbTHSVxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 17:53:49 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52402 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261197AbTHSVxq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 17:53:46 -0400
Message-ID: <3F429C5D.4010201@pobox.com>
Date: Tue, 19 Aug 2003 17:53:33 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Linus Torvalds <torvalds@osdl.org>, akpm@ravnborg.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org
Subject: Re: kbuild: Separate ouput directory support
References: <20030819214144.GA30978@mars.ravnborg.org>
In-Reply-To: <20030819214144.GA30978@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> The following set of patches introduce support for
> separate output directory when building a kernel.
> Typical usage is building several kernels with different configurations -
> but based on the same kernel src.

Thanks, this is some pretty neat stuff.

Is it possible, with your patches, to build from a kernel tree on a 
read-only medium?

	Jeff



