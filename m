Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261601AbVDZPlC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbVDZPlC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 11:41:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbVDZPlB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 11:41:01 -0400
Received: from fire.osdl.org ([65.172.181.4]:59071 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261601AbVDZPk2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 11:40:28 -0400
Date: Tue, 26 Apr 2005 08:40:19 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: ismail =?ISO-8859-1?Q?d=F6nmez?= <ismail.donmez@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make dmfe documentation nicer
Message-Id: <20050426084019.59582738.rddunlap@osdl.org>
In-Reply-To: <2a4f155d050425235677549af6@mail.gmail.com>
References: <2a4f155d050425235677549af6@mail.gmail.com>
Organization: OSDL
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2005 09:56:36 +0300
ismail dönmez <ismail.donmez@gmail.com> wrote:

> Hi,
> 
> I sent this patch to Rusty Russell's trivial patch monkey _months_ ago
> but its still not in mainline so here I send it again. So please apply
> it to mainline.
> Here is what it changes :
> 
> - Indent it nicely
> - Add a tip that CNET network cards use Davicom chipsets
> - Add Maintainers/Contributors to the end of documentation like in other docs.

Please submit in proper format, including corrected
file name level (begin at linux/drivers/net/tulip/....).

See Documentation/SubmittingPatches,
http://linux.yyz.us/patch-format.html , and
http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt


then send it to jgarzik@pobox.com and netdev@oss.sgi.com, please.


Alternatively, you can try kernel-janitors if Rusty is not
responding...  (see http://janitor.kernelnewbies.org/ )

-- 
~Randy
