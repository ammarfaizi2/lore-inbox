Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030259AbVI3Kr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030259AbVI3Kr7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 06:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030261AbVI3Kr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 06:47:59 -0400
Received: from web26902.mail.ukl.yahoo.com ([217.146.176.91]:51640 "HELO
	web26902.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1030259AbVI3Kr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 06:47:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=B7jEDJx1qgeHgZrXuiE/edhZIah9bs5EWbP7y65ImQF0vGeq3SIxvmyfbl0GgUEm4uayrbHt1lwOD5UerJGid4IA1BYsqMPEDTQ1BuhMO51jApmbl8NkObIdciouIcu0PIG4u1MSPKPnbbitIQY6UsBYJTGUurNj7qEcfzTpZqw=  ;
Message-ID: <20050930104751.47898.qmail@web26902.mail.ukl.yahoo.com>
Date: Fri, 30 Sep 2005 12:47:51 +0200 (CEST)
From: Etienne Lorrain <etienne_lorrain@yahoo.fr>
Subject: Re: Linux SATA S.M.A.R.T. and SLEEP?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Coady wrote:
> jmerkey wrote:
> >Someone needs to fix SATA drive ordering in the kernel so it matches 
> >GRUBs ordering, or perhaps GRUB needs fixing. I have run into
>                     ^^^^^^^^^^^^^^^^^^^^^^^^^
> User-space issue?  Four of the last five drives I buy are SATA, I 
> don't see this problem 'cos I use lilo :o)

  Lilo is not the only bootloader which do not make random assumptions
 on the order of the drives - you should also try Gujin...
http://gujin.org

  Etienne.


	

	
		
___________________________________________________________________________ 
Appel audio GRATUIT partout dans le monde avec le nouveau Yahoo! Messenger 
Téléchargez cette version sur http://fr.messenger.yahoo.com
