Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751420AbWACRmc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbWACRmc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 12:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbWACRmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 12:42:32 -0500
Received: from ns.suse.de ([195.135.220.2]:41445 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751420AbWACRmb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 12:42:31 -0500
Date: Tue, 3 Jan 2006 18:42:30 +0100
From: Olaf Hering <olh@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 23/26] gitignore: x86_64 files
Message-ID: <20060103174229.GA31981@suse.de>
References: <20060103132035.GA17485@mars.ravnborg.org> <p73wthhi7v9.fsf@verdi.suse.de> <20060103171517.GB20001@mars.ravnborg.org> <200601031826.42028.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <200601031826.42028.ak@suse.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Tue, Jan 03, Andi Kleen wrote:

> > Today there are 23 .gitignores in the kernel - including the ones
> > from this patchset.
> 
> And next year .cvsignores and .svnignores and .hgignores and 
> .whateveriscurrentlyenvoguesvmignores ?

The correct fix would be:
Make 'O=$somedir' mandatory.

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
