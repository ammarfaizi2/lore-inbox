Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261460AbVFUN7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbVFUN7e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 09:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbVFUN4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 09:56:20 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:19903 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261425AbVFUNxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 09:53:01 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: <cutaway@bellsouth.net>, "Jesper Juhl" <juhl-lkml@dif.dk>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] cleanup patches for strings
Date: Tue, 21 Jun 2005 16:52:05 +0300
User-Agent: KMail/1.5.4
Cc: "Andrew Morton" <akpm@osdl.org>, "Jeff Garzik" <jgarzik@pobox.com>,
       "Domen Puncer" <domen@coderock.org>
References: <Pine.LNX.4.62.0506200052320.2415@dragon.hyggekrogen.localhost> <200506211606.59233.vda@ilport.com.ua> <01ff01c5766e$de750be0$2800000a@pc365dualp2>
In-Reply-To: <01ff01c5766e$de750be0$2800000a@pc365dualp2>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506211652.05817.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 June 2005 17:38, cutaway@bellsouth.net wrote:
> Congratulations, you proved that a register push is faster than a 3 byte
> memory push.  I believe this is exactly what I said would happen if the
> autovar pointer wound up being enregistered.
> 
> However, it is NOT what GCC will generate for pushing params to static
> strings.
> 
> For that you're going to get a 5 byte PUSH imm32.

My fault, I already mailed the corrected program.
Please see it. Now please admit you were wrong.
--
vda

