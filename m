Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281150AbRKTQHF>; Tue, 20 Nov 2001 11:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281147AbRKTQGz>; Tue, 20 Nov 2001 11:06:55 -0500
Received: from mta.sara.nl ([145.100.16.144]:48865 "EHLO mta.sara.nl")
	by vger.kernel.org with ESMTP id <S281150AbRKTQGp>;
	Tue, 20 Nov 2001 11:06:45 -0500
Message-Id: <200111201606.RAA21464@zhadum.sara.nl>
X-Mailer: exmh version 2.1.1 10/15/1999
From: Remco Post <r.post@sara.nl>
To: wr6@uni.de
cc: "J.A. Magallon" <jamagallon@able.es>, James A Sutherland <jas88@cam.ac.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: Swap 
In-Reply-To: Message from Wolfgang Rohdewald <wr6@uni.de> 
   of "Tue, 20 Nov 2001 17:01:30 +0100." <20011120160131.87644332@localhost.localdomain> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 20 Nov 2001 17:06:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tuesday 20 November 2001 15:51, J.A. Magallon wrote:
> > When a page is deleted for one executable (because we can re-read it from
> > on-disk binary), it is discarded, not paged out.
> 
> What happens if the on-disk binary has changed since loading the program?
> 
The application usually crashes, but in theory it may run with just some 
'strange' behaviour. (Don't worry, apps usually just crash ;)


-- 
Met vriendelijke groeten,

Remco Post

SARA - Stichting Academisch Rekencentrum Amsterdam
High Performance Computing  Tel. +31 20 592 8008    Fax. +31 20 668 3167

"I really didn't foresee the Internet. But then, neither did the computer
industry. Not that that tells us very much of course - the computer industry
didn't even foresee that the century was going to end." -- Douglas Adams


