Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbWFBNqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWFBNqp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 09:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbWFBNqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 09:46:45 -0400
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:50276 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932099AbWFBNqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 09:46:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=VxOdxdZycbIMuovNS6c+ey3eQQnXhZZVPaBvvIOnfz+fjRXWjxeG7D353XP2KPT/WjuVpTBCWM4R49hLBOMtfMoFiFY3pnI+Ye4ochW42P5c9nNXML8721QT0GdwtYtWEjb14KfVaxWiD9IOdbyUeE0TzEJoi56EEoTBpqRCsqs=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: [discuss] [RFC] [PATCH] Double syscall exit traces on x86_64
Date: Thu, 1 Jun 2006 21:07:33 +0200
User-Agent: KMail/1.9.1
Cc: Jeff Dike <jdike@addtoit.com>, Andi Kleen <ak@suse.de>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, Steven James <pyro@linuxlabs.com>,
       Roland McGrath <roland@redhat.com>
References: <20060526032424.GA8283@ccure.user-mode-linux.org> <200605261236.26814.ak@suse.de> <20060526141345.GA4152@ccure.user-mode-linux.org>
In-Reply-To: <20060526141345.GA4152@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606012107.34676.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 26 May 2006 16:13, Jeff Dike wrote:
> On Fri, May 26, 2006 at 12:36:26PM +0200, Andi Kleen wrote:
> > I believe this patch is the correct fix. Can you confirm it works for
> > you?
>
> Looks good, thanks.
>
> 		Jeff
Sorry for the question, but has this been sent to -stable (since it's a 
-stable regression, it should be)? To 2.6.17 -git?

And have you tested it (somebody should have, but it's not sure)?
Sorry for not helping myself, I'll be back at work ASAP.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
