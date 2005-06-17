Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261933AbVFQJ5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261933AbVFQJ5I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 05:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261934AbVFQJ5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 05:57:08 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:39349 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S261933AbVFQJ5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 05:57:03 -0400
From: Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>
Subject: Re: A Great Idea (tm) about reimplementing NLS.
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       Lukasz Stelmach <stlman@poczta.fm>, mru@inprovide.com,
       Patrick McFarland <pmcfarland@downeast.net>,
       "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Fri, 17 Jun 2005 11:56:32 +0200
References: <4glbh-xY-27@gated-at.bofh.it> <4glbh-xY-29@gated-at.bofh.it> <4glbh-xY-31@gated-at.bofh.it> <4glbh-xY-33@gated-at.bofh.it> <4glbh-xY-35@gated-at.bofh.it> <4glbh-xY-37@gated-at.bofh.it> <4glbh-xY-39@gated-at.bofh.it> <4glbh-xY-41@gated-at.bofh.it> <4glbh-xY-25@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1DjDaV-0001lo-4W@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org> wrote:
> Lennart Sorensen <lsorense@csclub.uwaterloo.ca> wrote:

>> VFAT uses unicode?  I thought it used the same codepage silyness as FAT
>> did, since after all ti was just supposed to be a long filename
>> extension to FAT.  Do they use unicode in the long filenames only?
> 
> It uses two codepages, one for short names and one for long names.
> The long name charset defaults to iso-8859-1, and the short one to cp437

I rememberd wrong, it's utf16.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
