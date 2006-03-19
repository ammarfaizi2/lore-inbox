Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932230AbWCTMDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbWCTMDm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 07:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbWCTMDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 07:03:41 -0500
Received: from smtp008.mail.ukl.yahoo.com ([217.12.11.62]:37251 "HELO
	smtp008.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932095AbWCTMDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 07:03:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Disposition:Message-Id:Content-Type:Content-Transfer-Encoding;
  b=0EcXnJ9hHcn3eB9k8kPWD2+b6NYVrCteSvFbCPs4LVYMDfM4y1dWvy9MqnPeb3aIapC6JEguLIfxZIYc8yD7fSviBHg2Ft3crgypwaR9WXZf75V4IFuucokHiypivIYQ7L8YCfq4QTgFEngNwbNieiVkvpYzdHVqwNaJHgqj8HU=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Proposed additions to the ptrace(2) manpage, take 2
Date: Sun, 19 Mar 2006 20:41:34 +0100
User-Agent: KMail/1.8.3
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Michael Kerrisk <mtk-manpages@gmx.net>,
       Daniel Jacobowitz <dan@debian.org>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       "Charles P. Wright" <cwright@cs.sunysb.edu>
References: <200603180714_MC3-1-BAEF-EBBE@compuserve.com>
In-Reply-To: <200603180714_MC3-1-BAEF-EBBE@compuserve.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200603192041.34981.blaisorblade@yahoo.it>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 March 2006 13:12, Chuck Ebbert wrote:
> This is a revised set of updates to the ptrace(2) manpage.
>
> Comments?

For all I can comment about, this patch is correct, so:

Acked-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Only note that SYSEMU and SYSEMU_SINGLESTEP are for now x86-only (not even 
x86_64 yet).
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
