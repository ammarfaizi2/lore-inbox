Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270498AbTHHKXS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 06:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270630AbTHHKXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 06:23:18 -0400
Received: from gate.corvil.net ([213.94.219.177]:42503 "EHLO corvil.com")
	by vger.kernel.org with ESMTP id S270498AbTHHKXR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 06:23:17 -0400
Message-ID: <3F337A1D.8020707@draigBrady.com>
Date: Fri, 08 Aug 2003 11:23:25 +0100
From: P@draigBrady.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: csg <chr@abelard.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Readonly mounted ext2 filesystem partition changeable: Bug or
 Feature?
References: <oprtmunmkc06yy9w@smtp.1und1.com>
In-Reply-To: <oprtmunmkc06yy9w@smtp.1und1.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

csg wrote:
> [PLEASE copy any answer to this posting to
>    chr@abelard.de
> Thanks.]
> 
> Hello,
> 
> Short: I have seen changes made to a readonly mounted ext2 filesystem by
> communicating with /sbin/init via /dev/initctl. This strange behaviour
> goes away while moving /dev into RAM by using DEVFS.
> 
> In my opinion this is a bug. Or is it a feature?

A bug that is already fixed:
http://marc.theaimsgroup.com/?t=105414508000003&r=1&w=2

Pádraig.

