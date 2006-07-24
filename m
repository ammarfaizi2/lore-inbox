Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbWGXOod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbWGXOod (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 10:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbWGXOod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 10:44:33 -0400
Received: from web36414.mail.mud.yahoo.com ([209.191.85.149]:60817 "HELO
	web36414.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932196AbWGXOod (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 10:44:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=OhepMig1JPzDwGMS+ZhJ4D9EHyVeNWFT86af1Txkl8Fxa86ghoCQ4NG7s1C7Fc3p5bfBZmdhLMSp7Q37bpKd+8vq/Llyfh6rqruy5gFuBU9ablQFWP4zsunGQYeOdJWv49wL7XzeF4ax8JIoDhCHZZEVlESdQyzKFXT/0ZAdj5E=  ;
Message-ID: <20060724144432.35332.qmail@web36414.mail.mud.yahoo.com>
Date: Mon, 24 Jul 2006 07:44:32 -0700 (PDT)
From: Dennis Jacob <dennis_jacob_78@yahoo.com>
Subject: DSP software for ixp board
To: Linux-Kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

     I want to port an application to intel ixp with
snapgear 2.4.31. For SLIC / SLAC support in the board,
I want to use the DSP software from intel and the
version now available from intel site is
DSR2.6.2Release. But I am using intel ixp libs V2.0
and the doccumentation with the DSP s/w tells to use
ixp libs 1.4v. 

    May be because of that, when I am  making the
kernel I am getting some compilation errors

  Can anybody tell me whether there is any version of
DSR s/w which complys with ixp libs v2.0?

Thanks
Dennis

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
