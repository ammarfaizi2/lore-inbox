Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266023AbUGJAGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266023AbUGJAGp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 20:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266028AbUGJAGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 20:06:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:62863 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266023AbUGJAGo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 20:06:44 -0400
Date: Fri, 9 Jul 2004 17:06:40 -0700
From: "David S. Miller" <davem@redhat.com>
To: Thomas DuBuisson <tomd@csds.uidaho.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Crypto] twofish-flag.patch
Message-Id: <20040709170640.0a3989d8.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.53.0407091006040.11273@scooter.csds.uidaho.edu>
References: <Pine.LNX.4.53.0407091006040.11273@scooter.csds.uidaho.edu>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jul 2004 10:12:12 -0700 (PDT)
Thomas DuBuisson <tomd@csds.uidaho.edu> wrote:

> Unless there is a good reason for the flag handling to be different in 
> twofish than in AES or Serpent I think this needs applied.  It just sets 
> the proper flag if someone tries to run twofish_setkey with an improper 
> key size.

Applied, thanks Thomas.

