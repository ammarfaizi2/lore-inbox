Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263868AbUBRJe3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 04:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264283AbUBRJe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 04:34:29 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:24592 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S263868AbUBRJe2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 04:34:28 -0500
Message-ID: <403334AF.7090106@aitel.hist.no>
Date: Wed, 18 Feb 2004 10:47:27 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: no, en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: UTF-8 and case-insensitivity
References: <16433.38038.881005.468116@samba.org>	<Pine.LNX.4.58.0402162034280.30742@home.osdl.org>	<16433.47753.192288.493315@samba.org>	<16433.53708.264048.307137@notabene.cse.unsw.edu.au>	<16434.39473.822318.998268@samba.org> <16434.44139.524682.438028@notabene.cse.unsw.edu.au>
In-Reply-To: <16434.44139.524682.438028@notabene.cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:

>     1/ case gets lost, so if I save "My File", I will find "my file"
>     has been created (unless the application pretty-cases things, in
>     which case I can expect case to change anyway).
> 
>     2/ Files created by posix apps might be invisible.
> 
> 
>     To answer 2/, I'd say "tough".  If you want posix files to be

This is a bit worse than just "though".  
win32: rmdir foo
       directory not empty!
win32: there are _no_ files there?

Helge Hafting

