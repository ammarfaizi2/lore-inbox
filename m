Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264867AbTAJK7L>; Fri, 10 Jan 2003 05:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264875AbTAJK7L>; Fri, 10 Jan 2003 05:59:11 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:30609
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264867AbTAJK7K>; Fri, 10 Jan 2003 05:59:10 -0500
Subject: Re: [TRIVIAL] [PATCH 1 of 3] Fix errors making Docbook
	documentation
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Craig Wilkie <craig@homerjay.homelinux.org>
In-Reply-To: <20030110073328.A11712C0DD@lists.samba.org>
References: <20030110073328.A11712C0DD@lists.samba.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042199637.28469.52.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 10 Jan 2003 11:53:58 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-01-10 at 00:50, Rusty Russell wrote:
> > Please don't do this. The proper fixes already exist just never got
> > merged. Also documentation exists for those files and isnt merged. The
> > docbook is not the problem, the pile of other missing bits is
> > 
> > Grab the docbook for those files from 2.4 and also the changes to the
> > docbook generator
> 
> Too late, Linus took it.  Craig, since you're doing Documentation
> patches, a forward port would be nice.

I thought bitkeeper had an "exclude" function ?

Alan

