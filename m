Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264330AbUDSKGH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 06:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264341AbUDSKGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 06:06:06 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:2733 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S264330AbUDSKGE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 06:06:04 -0400
Date: Mon, 19 Apr 2004 12:06:03 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Oprofilefs cant handle > 99 cpus
Message-ID: <20040419100603.GI12480@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040418110658.GC26086@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20040418110658.GC26086@krispykreme>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-04-18 21:06:58 +1000, Anton Blanchard <anton@samba.org>
wrote in message <20040418110658.GC26086@krispykreme>:
> Oprofilefs cant handle > 99 cpus. This should fix it.

Erm, on what hardware are you testing? Some large POWER5 machine?

MfG, JBG

-- 
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier Bürger" | im Internet! |   im Irak!
   ret = do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA));
