Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265624AbRFWEyz>; Sat, 23 Jun 2001 00:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265626AbRFWEyo>; Sat, 23 Jun 2001 00:54:44 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:33041 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S265624AbRFWEyc>;
	Sat, 23 Jun 2001 00:54:32 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: stimits@idcomm.com
cc: linux-kernel@vger.kernel.org
Subject: Re: Cleanup kbuild for aic7xxx 
In-Reply-To: Your message of "Fri, 22 Jun 2001 22:17:12 CST."
             <3B341848.1EF6DA3B@idcomm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 23 Jun 2001 14:54:22 +1000
Message-ID: <13170.993272062@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jun 2001 22:17:12 -0600, 
"D. Stimits" <stimits@idcomm.com> wrote:
> On Fri, 22 Jun 2001 13:39:45 -0600,
>> "Justin T. Gibbs" <gibbs@scsiguy.com> wrote:
>> Users don't have to manually select "rebuild firmware".  They can
>> rely on the generated files already in the aic7xxx directory.  This
>> is why the option defaults to off.
>
>For the SGI patched kernels based on either 2.4.5 or 2.4.6-pre1, I have
>had to manually select this for a 7892 controller. Without manually
>selecting it, it guarantees boot failure. I don't know if this is due to
>the SGI modifications or not.

It is a side effect of the SGI source control system.

