Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264463AbTLEWl5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 17:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264494AbTLEWl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 17:41:57 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:15298 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S264463AbTLEWlz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 17:41:55 -0500
Date: Fri, 5 Dec 2003 14:41:42 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: M?ns Rullg?rd <mru@kth.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is there a "make hole" (truncate in middle) syscall?
Message-ID: <20031205224142.GR29119@mis-mike-wstn.matchmail.com>
Mail-Followup-To: M?ns Rullg?rd <mru@kth.se>, linux-kernel@vger.kernel.org
References: <200312041432.23907.rob@landley.net> <Pine.LNX.4.58.0312042300550.2330@ua178d119.elisa.omakaista.fi> <yw1xllprihwo.fsf@kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yw1xllprihwo.fsf@kth.se>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 05, 2003 at 01:11:03PM +0100, M?ns Rullg?rd wrote:
> I found this paragraph in the man page of GNU cp:
> 
>        --sparse=WHEN
>               always Always make the output file sparse.  This is
>                      useful when the  input  file  resides  on  a
>                      filesystem  that  does  not  support  sparse
>                      files, but the output file is on a  filesys-
>                      tem that does.

So with this, you can create sparse files for an entire set of files by just
cping them? :)
