Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281060AbRKOUz2>; Thu, 15 Nov 2001 15:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281059AbRKOUzT>; Thu, 15 Nov 2001 15:55:19 -0500
Received: from ppp-46-120.28-151.libero.it ([151.28.120.46]:12036 "HELO
	gateway.milesteg.arr") by vger.kernel.org with SMTP
	id <S281060AbRKOUzJ>; Thu, 15 Nov 2001 15:55:09 -0500
Date: Thu, 15 Nov 2001 22:50:44 +0100
From: Daniele Venzano <venza@iol.it>
To: Nicolas Aspert <Nicolas.Aspert@epfl.ch>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Robert Love <rml@tech9.net>
Subject: Re: Problem with i820 AGP patch [SOLVED]
Message-ID: <20011115225044.A809@renditai.milesteg.arr>
In-Reply-To: <20011114205141.A1065@renditai.milesteg.arr> <3BF37672.50006@epfl.ch> <20011115201146.A1279@renditai.milesteg.arr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011115201146.A1279@renditai.milesteg.arr>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2001 at 08:11:46PM +0100, Daniele Venzano wrote:
> Both (sigh!), the problem shows with or without your patch.
> Now I'm tring your new patch, but I don't think something will change.

I was wrong, now (with 2.4.15-pre4 and Nicolas patch) everything is
working fine, the module agpgart loads finding my i820 chipset and my
OpenGL apps work correctly with more than 256Mb of RAM.

Thank you very much for your work.
Regards.

-- 
-----------------------------------------------------
Daniele Venzano
Senior member of the Linux User Group Genova (LUGGe)
E-Mail: venza@iol.it
Web: http://digilander.iol.it/webvenza/
LUGGe: http://lugge.ziobudda.net

