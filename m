Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316789AbSGVLKi>; Mon, 22 Jul 2002 07:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316792AbSGVLKi>; Mon, 22 Jul 2002 07:10:38 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:16380 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316789AbSGVLKh>; Mon, 22 Jul 2002 07:10:37 -0400
Subject: Re: Dual BSD/GPL [ was: Re: Generic modules documentation is
	outdated]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Rodland <arodland@noln.com>
Cc: Yann Dirson <ydirson@altern.org>, linux-kernel@vger.kernel.org,
       kaos@ocs.com.au
In-Reply-To: <20020723025639.1baf8c1b.arodland@noln.com>
References: <20020704212240.GB659@bylbo.nowhere.earth>
	<20020718210259.GJ19580@bylbo.nowhere.earth>
	<1027032521.8154.48.camel@irongate.swansea.linux.org.uk>
	<20020718232535.GB8165@bylbo.nowhere.earth> 
	<20020723025639.1baf8c1b.arodland@noln.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 22 Jul 2002 13:25:45 +0100
Message-Id: <1027340745.31782.1.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-07-23 at 07:56, Andrew Rodland wrote:
> 
> 	* According to Alan Cox, a license of "BSD without advertisement
> 	clause" is not a suitable free software license. This license type
> 	allows binary only modules without source code. Any modules in the
> 	kernel tarball with this license should really be "Dual BSD/GPL".

The problem with just the BSD tag is that means it might be binary only
so undebuggable. If its dual BSD/GPL then at the least the user can
demand their GPL rights and get the source to debug it

I think all these are now sorted

