Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281557AbRLICLr>; Sat, 8 Dec 2001 21:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281558AbRLICLh>; Sat, 8 Dec 2001 21:11:37 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:61194 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S281557AbRLICLZ>;
	Sat, 8 Dec 2001 21:11:25 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Jerrad Pierce <belg4mit@dirty-bastard.pthbb.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.14/16 load reboots 
In-Reply-To: Your message of "Sat, 08 Dec 2001 15:22:27 CDT."
             <200112082022.fB8KMRJ27452@dirty-bastard.pthbb.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 09 Dec 2001 13:11:10 +1100
Message-ID: <17725.1007863870@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 08 Dec 2001 15:22:27 -0500, 
Jerrad Pierce <belg4mit@dirty-bastard.pthbb.org> wrote:
>PS> Why doesn't the CPU type *default* to whatever is listed
>in /proc/cpunifo? I say only default ince I realize people
>do build for other architectures.

In 2.5 there will be an option to probe the current hardware and
generate a specific config.

http://people.debian.org/~cate/files/kautoconfigure/autoconfigure/

