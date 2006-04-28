Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030483AbWD1QLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030483AbWD1QLZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 12:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030486AbWD1QLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 12:11:25 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:20126 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030483AbWD1QLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 12:11:23 -0400
Subject: Re: [ANNOUNCE] Release Digsig 1.5: kernel module for
	run-timeauthentication of binaries
From: Arjan van de Ven <arjan@infradead.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Ulrich Drepper <drepper@gmail.com>,
       Axelle Apvrille <axelle_apvrille@yahoo.fr>, Nix <nix@esperi.org.uk>,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
       disec-devel@lists.sourceforge.net
In-Reply-To: <20060428160914.GA31473@sergelap.austin.ibm.com>
References: <87slo2nn0b.fsf@hades.wkstn.nix>
	 <20060425161139.87285.qmail@web26109.mail.ukl.yahoo.com>
	 <a36005b50604280833k5a811384r5f3a6f92dd707256@mail.gmail.com>
	 <20060428160914.GA31473@sergelap.austin.ibm.com>
Content-Type: text/plain
Date: Fri, 28 Apr 2006 18:11:09 +0200
Message-Id: <1146240670.3126.20.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> A one time effort to write it *and sign it*.
you don't sign nor need to sign perl or bash scripts. Why would a loader
be written in ELF itself? There's absolutely no reason for that.

