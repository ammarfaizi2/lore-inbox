Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261295AbTA1VSg>; Tue, 28 Jan 2003 16:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261330AbTA1VSg>; Tue, 28 Jan 2003 16:18:36 -0500
Received: from ns.suse.de ([213.95.15.193]:21516 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261295AbTA1VSf>;
	Tue, 28 Jan 2003 16:18:35 -0500
Date: Tue, 28 Jan 2003 22:27:53 +0100
From: Andi Kleen <ak@suse.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: two x86_64 fixes for 2.4.21-pre3
Message-ID: <20030128212753.GA29191@wotan.suse.de>
References: <15921.37163.139583.74988@harpo.it.uu.se> <20030124193721.GA24876@wotan.suse.de> <15926.60767.451098.218188@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15926.60767.451098.218188@harpo.it.uu.se>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It looks as if %gs handling isn't quite right.

You are running vanilla 2.4.21pre3, right? 

I just noticed that my big update which has this all fixed went 
only in after pre3. Get one of the bitkeeper snapshots from Marcelo
or alternatively if you want the latest'n'greatest check out an 
CVS tree from cvs.x86-64.org (www.x86-64.org has instructions)

-Andi

