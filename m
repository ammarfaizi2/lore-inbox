Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262392AbTABQUW>; Thu, 2 Jan 2003 11:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262395AbTABQUW>; Thu, 2 Jan 2003 11:20:22 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:54919
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262392AbTABQUV>; Thu, 2 Jan 2003 11:20:21 -0500
Subject: Re: kernel .config support?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0301020930510.7804-100000@dell>
References: <Pine.LNX.4.44.0301020930510.7804-100000@dell>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 02 Jan 2003 17:11:45 +0000
Message-Id: <1041527505.24830.3.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-01-02 at 14:32, Robert P. J. Day wrote:
> 
>   whatever happened to that funky option from 2.4 --
> for kernel .config support, which allegedly buried the
> config file inside the kernel itself.  (it never worked --
> the alleged extraction script scripts/extract-ikconfig
> depended on a program called "binoffset" that didn't 
> exist in that distribution.)

Its never been in the standard 2.4 kernel. The facility has been in the
-ac kernel, and was recently submitted for consideration in 2.5

