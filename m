Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161126AbVIPIcH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161126AbVIPIcH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 04:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161129AbVIPIcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 04:32:07 -0400
Received: from web51010.mail.yahoo.com ([206.190.39.129]:32118 "HELO
	web51010.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1161126AbVIPIcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 04:32:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=GvDIi2vcODS7BX5nipcs3hUm7x4+TRgfl/IHUOZ7TE0/QUYQPGpYHntpfQD08/v3CWAj9hCv3d2sksOQvKi78Pxyos/mSzBNBSjfqppAfevrc3jhlLq8g98Zu3qOqK55z4Oqa9Ddo98qLTdD3S+Sze7F2NIBGQJERZ8geeRg/pM=  ;
Message-ID: <20050916083200.28972.qmail@web51010.mail.yahoo.com>
Date: Fri, 16 Sep 2005 01:32:00 -0700 (PDT)
From: Ahmad Reza Cheraghi <a_r_cheraghi@yahoo.com>
Subject: Re: Automatic Configuration of a Kernel
To: Emmanuel Fleury <fleury@cs.aau.dk>, linux-kernel@vger.kernel.org
In-Reply-To: <432A8026.5060509@cs.aau.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Emmanuel Fleury <fleury@cs.aau.dk> wrote:

> Coywolf Qi Hunt wrote:
> > 
> > How about the idea that we have a .hwconfig file
> and we do `make
> > hwconfig' to generate it? So normal filesystems
> and network stack
> > stuff don't belong to hwconfig.
> > 
> > .hwconfig file merely stores the result from auto
> hardware detection.
> 
> Well, at the end you just want to have one .config
> file with everything
> inside. If I follow your logic we also should have a
> .fsconfig, a
> .netconfig, a .audioconfig, ... and so on.
> 
> So, working on the .config seems nice to me.
> 
> Simplicity is good ! ^_^
> 
Yes thats true. It will be a hard also, for those
Users which doesn't have that much experience for the
configuration of a Kernel.


		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
