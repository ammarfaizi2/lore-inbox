Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275690AbRIZXKc>; Wed, 26 Sep 2001 19:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275691AbRIZXKX>; Wed, 26 Sep 2001 19:10:23 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:49417 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S275690AbRIZXKL>; Wed, 26 Sep 2001 19:10:11 -0400
Subject: Re: Binary only module overview
To: crispin@wirex.com (Crispin Cowan)
Date: Thu, 27 Sep 2001 00:14:33 +0100 (BST)
Cc: greg@kroah.com (Greg KH), alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-security-module@wirex.com, linux-kernel@vger.kernel.org
In-Reply-To: <3BB25BA3.1060505@wirex.com> from "Crispin Cowan" at Sep 26, 2001 03:50:11 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15mNsv-0002Cv-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm really trying to be constructive here.  There is a real licensing 
> problem over whether binary modules are legitimate at all, and the issue 
> is not special to LSM. I'm trying to get LSM out of the way so that the 
> advocates of either side can fight it out without smushing LSM in the 
> middle :-)

Yes - I agree. The question is "can you be using the LSM module" not
the headers - since LSM is GPL and your work relies on it 

Alan
