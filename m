Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932111AbWJFV7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbWJFV7b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 17:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbWJFV7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 17:59:31 -0400
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:56491 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932111AbWJFV7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 17:59:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=IUPcy6Xi9AMBB0qhaIyBevXNxs3f2vigwm1X8Hpu6MQDiTFOEmJiHT7TUOPWmlMv1JBD2SN7Fkcfp0fvfvbjQAwNL8I0CJhog1CGNQzsproxXQWLWmUlD3NOMEzFEbo0gY5roHToGluoEigxkn0lQC6dLPuIspKGta093+9EMts=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH 02/14] uml: revert wrong patch
Date: Thu, 5 Oct 2006 23:45:03 +0200
User-Agent: KMail/1.9.1
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org
References: <20061005213212.17268.7409.stgit@memento.home.lan> <20061005213839.17268.28062.stgit@memento.home.lan> <200610052345.09704.ak@suse.de>
In-Reply-To: <200610052345.09704.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610052345.03900.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 October 2006 23:45, Andi Kleen wrote:
> On Thursday 05 October 2006 23:38, Paolo 'Blaisorblade' Giarrusso wrote:
> > Andi Kleen pointed out that -mcmodel=kernel does not make sense for
> > userspace code and would stop everything from working,
>
> did it work at all with it?
Guess not, I should have boot-tested it... :-(. Sorry.

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade

Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
