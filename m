Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319182AbSHTOlJ>; Tue, 20 Aug 2002 10:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319184AbSHTOlJ>; Tue, 20 Aug 2002 10:41:09 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:777 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319182AbSHTOlI>; Tue, 20 Aug 2002 10:41:08 -0400
Date: Tue, 20 Aug 2002 15:45:01 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Thunder from the hill <thunder@lightweight.ods.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
       viro@math.psu.edu
Subject: Re: klibc and logging
Message-ID: <20020820154501.B31614@flint.arm.linux.org.uk>
References: <20020819175429.C17471@flint.arm.linux.org.uk> <Pine.LNX.4.44.0208200721490.3234-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0208200721490.3234-100000@hawkeye.luckynet.adm>; from thunder@lightweight.ods.org on Tue, Aug 20, 2002 at 07:22:18AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2002 at 07:22:18AM -0600, Thunder from the hill wrote:
> On Mon, 19 Aug 2002, Russell King wrote:
> > Without something like this, it means that effectively the "echo"
> > command wouldn't be useable, or you'd have to pipe the output of all
> > scripts through some program/to /dev/kmsg.
> 
> Isn't there "logger"?

No.  Not yet.  I've not grabbed/written/otherwise created that yet for
initramfs.  I don't think its really needed at the moment anyway.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

