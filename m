Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263413AbUGFHGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263413AbUGFHGO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 03:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263467AbUGFHGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 03:06:14 -0400
Received: from atropo.wseurope.com ([195.110.122.67]:16809 "EHLO
	atropo.wseurope.com") by vger.kernel.org with ESMTP id S263413AbUGFHGJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 03:06:09 -0400
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: Nathan Scott <nathans@sgi.com>
Subject: Re: XFS problem 2.6.7 vanilla
Date: Tue, 6 Jul 2004 09:06:06 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200407051033.10994.cova@ferrara.linux.it> <20040705201402.A2033082@wobbly.melbourne.sgi.com>
In-Reply-To: <20040705201402.A2033082@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200407060906.06604.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle 12:14, lunedì 5 luglio 2004, Nathan Scott ha scritto:
> On Mon, Jul 05, 2004 at 10:33:10AM +0200, Fabio Coatti wrote:
> > We are getting some error trace from xfs. I suppose that this can be due
> > to a faulty HD sector, but it sound strange to me that a HD error can
> > trigger an internal FS failure. We have tried several times to fix this
> > error with XFS repair without succes, so I suppose a hw error, but is the
> > aspected behaviour to get an internal FS error?
> > (2.6.7 vanilla)
>
> Could you try a current -bk tree (or XFS CVS on oss.sgi.com,
> for 2.6.7 + XFS updates), this should be resolved there now.


we aretrying right now bk18, after a xfs repair we don't see any error, so far 
so good. I'll keep pounding on FS and report back any issue.
Thanks for your help.


-- 
Fabio "Cova" Coatti    http://members.ferrara.linux.it/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.

