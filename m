Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbTJOVgb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 17:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbTJOVgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 17:36:31 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:11174 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S261906AbTJOVga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 17:36:30 -0400
Date: Wed, 15 Oct 2003 23:36:24 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: Nikita Danilov <Nikita@Namesys.COM>, Josh Litherland <josh@temp123.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Transparent compression in the FS
Message-ID: <20031015213624.GA29472@louise.pinerecords.com>
References: <1066163449.4286.4.camel@Borogove> <20031015133305.GF24799@bitwizard.nl> <16269.20654.201680.390284@laputa.namesys.com> <20031015142738.GG24799@bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031015142738.GG24799@bitwizard.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct-15 2003, Wed, 16:27 +0200
Erik Mouw <erik@harddisk-recovery.com> wrote:

> You have a point, but remember that modern IDE drives can do about
> 50MB/s from medium. I don't think you'll find a CPU that is able to
> handle transparent decompression on the fly at 50MB/s ... [snip]

You may want to check out LZO performance on a recent CPU.
http://www.oberhumer.com/opensource/lzo/

-- 
Tomas Szepe <szepe@pinerecords.com>
