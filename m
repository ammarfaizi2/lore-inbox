Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279247AbRJWFha>; Tue, 23 Oct 2001 01:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279249AbRJWFhU>; Tue, 23 Oct 2001 01:37:20 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:62980 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S279247AbRJWFhG>;
	Tue, 23 Oct 2001 01:37:06 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: tomlins@CAM.ORG
Cc: linux-kernel@vger.kernel.org
Subject: Re: VM 
In-Reply-To: Your message of "Mon, 22 Oct 2001 18:10:44 -0400."
             <20011022221044.B0B5D18F1A@oscar.casa.dyndns.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 23 Oct 2001 15:37:18 +1000
Message-ID: <1299.1003815438@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Oct 2001 18:10:44 -0400, 
Ed Tomlinson <tomlins@CAM.ORG> wrote:
>Daniel Phillips wrote:
>> If you want to argue for something, argue for giving config the ability to
>> apply patches, that would be lots of fun.
>
>Actually this _is_ a workable solution.  IBM has done it for decades with 
>its 'VM' operating system.
>
>You get a base file, a couple of control files, and a lists of patches.  
>When you go to build a nucleus (translate kernel) the patches are applied
>and the source assembled...

Same with the other mainframe systems, using something like SMP (System
Mangling/Management Product) to track the interdependencies.  But that
only works when almost all of the patches come from a single source
which does integration testing before releasing them.  This method does
not work well with multiple sources, look at the hassles third party
vendors have to go through to keep up with IBM patches.

Keith Owens (who spent far too many years fighting SMP)

