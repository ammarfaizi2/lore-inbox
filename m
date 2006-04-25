Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbWDYTh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbWDYTh4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 15:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbWDYThz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 15:37:55 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:32210 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751214AbWDYThz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 15:37:55 -0400
Subject: Re: [ANNOUNCE] Release Digsig 1.5: kernel module for
	run-timeauthentication of binaries
From: Arjan van de Ven <arjan@infradead.org>
To: Nix <nix@esperi.org.uk>
Cc: Axelle Apvrille <axelle_apvrille@yahoo.fr>, drepper@gmail.com,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
       disec-devel@lists.sourceforge.net
In-Reply-To: <878xpto53w.fsf@hades.wkstn.nix>
References: <20060425161139.87285.qmail@web26109.mail.ukl.yahoo.com>
	 <1145984201.3114.34.camel@laptopd505.fenrus.org>
	 <878xpto53w.fsf@hades.wkstn.nix>
Content-Type: text/plain
Date: Tue, 25 Apr 2006 21:37:48 +0200
Message-Id: <1145993869.3114.38.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-25 at 19:57 +0100, Nix wrote:
> On Tue, 25 Apr 2006, Arjan van de Ven said:
> > On Tue, 2006-04-25 at 18:11 +0200, Axelle Apvrille wrote:
> >> - finally, note you also have choice not to sign this
> >> elf loader of yours. If it isn't signed, it won't ever
> >> run ;-)
> > 
> > so you didn't sign perl ? or bash ?
> 
> You can write an elf loader in bash?!

I've not tried it.. but afaics bash scripts are sufficiently turing
complete to pull it off ;)


