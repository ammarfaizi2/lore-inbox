Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271129AbRICDYS>; Sun, 2 Sep 2001 23:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271135AbRICDYJ>; Sun, 2 Sep 2001 23:24:09 -0400
Received: from rj.sgi.com ([204.94.215.100]:41946 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S271129AbRICDYC>;
	Sun, 2 Sep 2001 23:24:02 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Jean-Luc Leger <reiga@dspnet.fr.eu.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: make xconfig problems 
In-Reply-To: Your message of "Mon, 03 Sep 2001 05:07:37 +0200."
             <20010903050737.A1223@dspnet.fr.eu.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 03 Sep 2001 13:24:05 +1000
Message-ID: <4664.999487445@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Sep 2001 05:07:37 +0200, 
Jean-Luc Leger <reiga@dspnet.fr.eu.org> wrote:
>Due to inexistant config.in files, make xconfig fail for the following architectures :
>* arm
>* cris
>* mips
>* mips64
>* sh
>
>Here is a patch for the 2.4.9 kernel :
>(a patch for the ac serie follows)

Did you apply the arch specific patches?  Most architectures will not
compile from Linus's tree, you need to apply extra patches first.

