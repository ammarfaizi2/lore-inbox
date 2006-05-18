Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbWERR23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbWERR23 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 13:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbWERR23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 13:28:29 -0400
Received: from web26601.mail.ukl.yahoo.com ([217.146.176.51]:34399 "HELO
	web26601.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932095AbWERR23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 13:28:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=NtYOLzvjBkTuWfvEP6kC8Lq7ccroj++tBdERWqfIdg1ds+qfeE+AmKIc0q7L6zSZQ+UXr/5ndJNtQu0vpqrZA3lrShUYyzyslo3X3MyyQPTLOsMUc/1dAwdTG16UskEVtHG+EcdIog3kn/oW5h+LTbgqd+iNZBuh0Ry+iTtvxLM=  ;
Message-ID: <20060518172827.73908.qmail@web26601.mail.ukl.yahoo.com>
Date: Thu, 18 May 2006 19:28:27 +0200 (CEST)
From: linux cbon <linuxcbon@yahoo.fr>
Subject: Re: replacing X Window System !
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
In-Reply-To: <446C61F8.7080406@aitel.hist.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- Helge Hafting <helge.hafting@aitel.hist.no> a
écrit : 

> All graphical applications - sure.

As already discussed here, not all graphical
applications should be rewritten, but only some
layers.
And none, if we can emulate X.


> Now you want to move graphichs into the kernel???

Unix was NOT designed for graphics.
Linux is supposed to be *modern*.

The kernel already drives the files system, the
network, the cdrom, the cpu, etc. Why not the graphics
?

Why dont we have "good" 3D support in X ?


> Your solution does not mean "no window system at
> all"
> You still got one, except now it is in the kernel
> and
> therefore more dangerous.  We do not have 2 os now,
> because X is _not_ an os.  Please look up what an os
> _is_,
> and you'll see that. 

I trust the linux kernel to command my hardware
correctly, so why not the graphical too ?


> Also, please tell why this would be faster, simpler,
> or
> easier to manage.  Stuff in the kernel is generally
> harder to manage than userspace stuff, and
> definitely
> not simpler.  Kernel code lives with all sorts of
> requirements
> and limitations that an application programmer would
> hate
> to have to worry about. 

Put X in the kernel, so we dont have 7924 bad written
incompatible implementations of it.
Even much better : put a replacement for X (and an X
emulation for old softwares), so we can have
simplicity, speed, 3D etc.

In my opinion, graphics do belong to the OS, like
sound, network and file system.


X implementations problems :
http://en.wikipedia.org/wiki/X_Window_System#Limitations_and_criticisms_of_X
http://www.std.org/~msm/common/protocol.pdf
http://archives.neohapsis.com/archives/openbsd/2006-03/0987.html
http://cbbrowne.com/info/xbloat.html


How to improve/replace X :
http://keithp.com/~keithp/talks/xarch_ols2004/xarch-ols2004-html/
http://www.doc.ic.ac.uk/teaching/projects/Distinguished03/MarkThomas.pdf


What is your opinion ? 


Thanks











	

	
		
___________________________________________________________________________ 
Faites de Yahoo! votre page d'accueil sur le web pour retrouver directement vos services préférés : vérifiez vos nouveaux mails, lancez vos recherches et suivez l'actualité en temps réel. 
Rendez-vous sur http://fr.yahoo.com/set
