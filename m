Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbVLPGQJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbVLPGQJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 01:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbVLPGQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 01:16:09 -0500
Received: from web50211.mail.yahoo.com ([206.190.39.175]:29034 "HELO
	web50211.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932147AbVLPGQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 01:16:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=wICZp8UKazJrP0o642qFrIYNw7uxiCL0R68i//YmiRpokT5DicUTM/d/LEB109TJvjBNk1F1sTRFItT/dHDWymNXyVQGZFVbjUxUWtyO2ZSc7GHki5/0A/Uq2lgMSyn3xR7pLOi3ZDDsBqRmyd8wYiQl1A2enLyfFHUgMLBNo5o=  ;
Message-ID: <20051216061605.46520.qmail@web50211.mail.yahoo.com>
Date: Thu, 15 Dec 2005 22:16:05 -0800 (PST)
From: Alex Davis <alex14641@yahoo.com>
Subject: Re: [2.6 patch] i386: always use 4k stacks
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051216052913.GD30754@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Dave Jones <davej@redhat.com> wrote:

> On Thu, Dec 15, 2005 at 09:20:54PM -0800, Alex Davis wrote:
>  > The problem is that, with laptops, most of the time you DON'T have a choice:
>  > HP and Dell primarily use a Broadcomm integrated wireless card in ther products.
>  > As of yet, there is no open source driver for Broadcomm wireless.
> 
> We've already been through all this the previous times this came up.
> 
> http://bcm43xx.berlios.de
> 
> Whilst it's in early stages, it's making progress.
> 
> 		Dave
> 
> 
I understand that, and am grateful for the effort, but the point is it's not ready. Are you
expecting people to lose an important feature of their
laptop until you get the driver ready? 


I code, therefore I am

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
