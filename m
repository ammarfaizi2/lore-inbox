Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313080AbSDDBgi>; Wed, 3 Apr 2002 20:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313082AbSDDBg3>; Wed, 3 Apr 2002 20:36:29 -0500
Received: from rj.SGI.COM ([204.94.215.100]:30898 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S313080AbSDDBgT>;
	Wed, 3 Apr 2002 20:36:19 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cleanup KERNEL_VERSION definition and linux/version.h 
In-Reply-To: Your message of "Thu, 04 Apr 2002 10:12:29 +0900."
             <20020404011251Z313077-616+5298@vger.kernel.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 04 Apr 2002 11:36:06 +1000
Message-ID: <17913.1017884166@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Apr 2002 10:12:29 +0900, 
Hiroyuki Toda <might@might.dyn.to> wrote:
>
>Keith> This file will change completely in 2.5 when kbuild 2.5 goes in.  Why
>Keith> does it need to be rearranged in 2.4?
>
>Will kbuild 2.5 go in 2.4 tree also?

No, but version.h is working at the moment in 2.4.  Why change it?

