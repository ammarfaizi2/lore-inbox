Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422803AbWCXJfM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422803AbWCXJfM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 04:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422804AbWCXJfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 04:35:12 -0500
Received: from web25815.mail.ukl.yahoo.com ([217.146.176.248]:5027 "HELO
	web25815.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1422803AbWCXJfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 04:35:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=jWyIQRth9QgOUCL5KrC3LpuHls1ZlOUAr+h7bEUisj5aCkUXkcYU1k+mOQ/UODpN+rM/jlQLRmqfv/jKRA4mSr4Zz9GfmjACCdqAEN7UF4KFOO19i4N56050FUD0TA1Cmj2uxPva8xa0y11YBLtQ0LBn8OOQOSZsvP/9ss4yB1U=  ;
Message-ID: <20060324093509.99437.qmail@web25815.mail.ukl.yahoo.com>
Date: Fri, 24 Mar 2006 10:35:09 +0100 (CET)
From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re: How to test vanilla kernel
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9a8748490603240100v33097236v1ccc79871b285941@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jesper,

--- Jesper Juhl <jesper.juhl@gmail.com> a écrit :
> > is it safe to
> > forget them ?
> >
> Unless you have something setup on your box which depends on
> functionality patched into the kernel by your vendor, then yes,

but how will I know that some shipped patchs are necessary ?

> running a vanilla kernel is perfectly OK - if it was not we'd never
> get it tested ;-)
> 

well, last time I tried to replace fedora core 3 kernel with a vanilla 2.6.15
kernel I have some troubles with my USB controller, I got some unhandled IRQ.
And some devices like UART have their minor numbers changed. So I'm wondering
when upgrading the kernel, some configurations must be done ?


Francis


	
	
		
___________________________________________________________________________ 
Nouveau : téléphonez moins cher avec Yahoo! Messenger. Appelez le monde entier à partir de 0,012 €/minute ! 
Téléchargez sur http://fr.messenger.yahoo.com
