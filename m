Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266025AbUFPAHC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266025AbUFPAHC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 20:07:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266028AbUFPAHC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 20:07:02 -0400
Received: from lakermmtao11.cox.net ([68.230.240.28]:54011 "EHLO
	lakermmtao11.cox.net") by vger.kernel.org with ESMTP
	id S266025AbUFPAHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 20:07:01 -0400
In-Reply-To: <20040615170109.U21045@build.pdx.osdl.net>
References: <772741DF-BC19-11D8-888F-000393ACC76E@mac.com> <1087080664.4683.8.camel@lade.trondhjem.org> <D822E85F-BCC8-11D8-888F-000393ACC76E@mac.com> <1087084736.4683.17.camel@lade.trondhjem.org> <DD67AB5E-BCCF-11D8-888F-000393ACC76E@mac.com> <87smcxqqa2.fsf@asterisk.co.nz> <8666.1087292194@redhat.com> <3943FF92-BEFE-11D8-95EB-000393ACC76E@mac.com> <20040615150707.B22989@build.pdx.osdl.net> <880FEF02-BF26-11D8-95EB-000393ACC76E@mac.com> <20040615170109.U21045@build.pdx.osdl.net>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <118244B4-BF29-11D8-95EB-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Blair Strang <bls@asterisk.co.nz>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       lkml <linux-kernel@vger.kernel.org>,
       David Howells <dhowells@redhat.com>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: In-kernel Authentication Tokens (PAGs)
Date: Tue, 15 Jun 2004 20:06:51 -0400
To: Chris Wright <chrisw@osdl.org>
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 15, 2004, at 20:01, Chris Wright wrote:
> Just commenting on your desire to "create a new shell with a new
> keyring.."  This had clone() implicit in it.

Ah, it did indeed.  Sorry for the confusion! :-D

Cheers,
Kyle Moffett

