Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317036AbSGXVz0>; Wed, 24 Jul 2002 17:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317034AbSGXVz0>; Wed, 24 Jul 2002 17:55:26 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:53515 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317036AbSGXVz0>; Wed, 24 Jul 2002 17:55:26 -0400
Date: Wed, 24 Jul 2002 22:58:35 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: James Simmons <jsimmons@transvirtual.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: [PATCH] Second set of console changes.
Message-ID: <20020724225835.H25115@flint.arm.linux.org.uk>
References: <Pine.LNX.4.44.0207241157540.9506-100000@www.transvirtual.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0207241157540.9506-100000@www.transvirtual.com>; from jsimmons@transvirtual.com on Wed, Jul 24, 2002 at 01:08:33PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2002 at 01:08:33PM -0700, James Simmons wrote:
>  drivers/char/sysrq.c           |  486 ----

Do you really mean to remove _all_ sysrq functionality from the kernel,
thereby removing an important debugging feature?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

