Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318037AbSGRMbe>; Thu, 18 Jul 2002 08:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318038AbSGRMbe>; Thu, 18 Jul 2002 08:31:34 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:3317 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318037AbSGRMbd>; Thu, 18 Jul 2002 08:31:33 -0400
Subject: Re: 2.4.18 is not SMP friendly
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: devik <devik@cdi.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0207181244550.535-100000@devix>
References: <Pine.LNX.4.33.0207181244550.535-100000@devix>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 18 Jul 2002 14:45:05 +0100
Message-Id: <1026999905.9727.13.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-07-18 at 11:51, devik wrote:
> I someone here running 2.4.18 on PII SMP successfully ?

PPro in my case but yes. 2.4.18 ought to be pretty solid except for some
annoying bugs you'll only hit if you use smbfs. 

