Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290118AbSAXUPT>; Thu, 24 Jan 2002 15:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290206AbSAXUPJ>; Thu, 24 Jan 2002 15:15:09 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35080 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S290118AbSAXUO4>;
	Thu, 24 Jan 2002 15:14:56 -0500
Message-ID: <3C506B3D.3DC81E42@mandrakesoft.com>
Date: Thu, 24 Jan 2002 15:14:53 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Oliver Xymoron <oxymoron@waste.org>
CC: Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: RFC: booleans and the kernel
In-Reply-To: <Pine.LNX.4.44.0201241404520.2839-100000@waste.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Xymoron wrote:
> Because you never test against X==true. You always test X!=false. This is
> the C way.

That is the theory, yes... :)

-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
