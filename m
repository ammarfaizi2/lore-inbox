Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290797AbSEAJEE>; Wed, 1 May 2002 05:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292855AbSEAJED>; Wed, 1 May 2002 05:04:03 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:42199 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S290797AbSEAJEC>;
	Wed, 1 May 2002 05:04:02 -0400
Date: Wed, 1 May 2002 05:03:57 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Gregoire Favre <greg@ulima.unil.ch>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.12 compil error
In-Reply-To: <20020501085535.GA14645@ulima.unil.ch>
Message-ID: <Pine.GSO.4.21.0205010503150.11514-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 1 May 2002, Gregoire Favre wrote:

> Hello,
> 
> sorry if it has altrady been posted: I have looked for it at google but
> didn't found it...

you forgot to redo make dep after patching.

