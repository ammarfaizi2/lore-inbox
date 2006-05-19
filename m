Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbWESWJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbWESWJv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 18:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbWESWJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 18:09:51 -0400
Received: from web26605.mail.ukl.yahoo.com ([217.146.176.55]:13171 "HELO
	web26605.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751167AbWESWJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 18:09:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=j7t+gjY9EAA5bZi/j+eFVv26KF7VcSW+yf3UTj582I3zs9lep1HT53DlWBKSjBwwfqBgr1Ezlc8UY7hrVjH/lw4LylAtjkhdjx2T3AxpP0+7UTQxRfyFTintoIx2v65/qtyxNXAZL+b/eIMtsIPDFM8mOErujZ2GjCZUkwjcH/g=  ;
Message-ID: <20060519220949.41083.qmail@web26605.mail.ukl.yahoo.com>
Date: Sat, 20 May 2006 00:09:49 +0200 (CEST)
From: linux cbon <linuxcbon@yahoo.fr>
Subject: Re: replacing X Window System !
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: Panagiotis Issaris <takis@lumumba.uhasselt.be>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org, David Greaves <david@dgreaves.com>
In-Reply-To: <1148051890.26628.138.camel@capoeira>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- Xavier Bestel <xavier.bestel@free.fr> a écrit : 
> On Fri, 2006-05-19 at 17:13, linux cbon wrote:
> > Hi,
> > 
> > does DRI access hardware *directly* ?
> 
> Yes it does.
> 
> > How does DRI compare with other drivers ?
> 
> DRI is not finished for r300 cards (radeon 9600 =>
> X700 IIRC), but it
> kind of works. The only other driver I know for r300
> is Xorg's radeon,
> and it's dead slow.
> 
> 	Xav


Are "DRIs" the best available open-source drivers for
old ATI cards ? Done by reverse engineering ?
And not all functions are usable :-(.
What about newer ATI or Nvidia cards ? A hope for
something better ?

What do you think of using binary drivers (blobs)
instead ?
I think thats sad to use them, in an open-source
kernel like Linux.

By the way : did you know of this project about an
"open source graphic card" ?
Hardware specs are open, so no need of DNA and
open-source drivers coding easier :
http://opengraphics.gitk.com/open_graphics_spec.pdf
http://lists.duskglow.com/mailman/listinfo/open-graphics
(still a project).


Regards







	
	
		
___________________________________________________________________________ 
Nouveau : téléphonez moins cher avec Yahoo! Messenger. Appelez le monde entier à partir de 0,012 €/minute !
Téléchargez sur http://fr.messenger.yahoo.com
