Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261801AbVCGWLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbVCGWLQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 17:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbVCGWFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 17:05:17 -0500
Received: from rproxy.gmail.com ([64.233.170.197]:53546 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261265AbVCGVgF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 16:36:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=lMydeRGEWUgMpEsXwSHyNfUHYypFncG1tiUMQGjI+l6R5p9g9FMrgLwmsqkokf2j/gRSUEZTVrmr/p1Fu/oHD3xbhc2/3b0Dqo6Rk2dplZeZp4kd85Um2PZ85GN7tJE7ETrzL+k1G9TnfN+r/KxUc062racl25RH4T/iRmTW/fc=
Message-ID: <d120d50005030713366626691e@mail.gmail.com>
Date: Mon, 7 Mar 2005 16:36:04 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Peter Osterlund <petero2@telia.com>
Subject: Re: Touchpad "tapping" changes in 2.6.11?
Cc: Henrik Persson <root@fulhack.info>, linux-kernel@vger.kernel.org
In-Reply-To: <m37jkjdu15.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <422C539A.4040407@fulhack.info>
	 <d120d500050307055522415fb3@mail.gmail.com>
	 <422C7CF3.9080609@fulhack.info>
	 <d120d50005030708365a4917c5@mail.gmail.com> <m37jkjdu15.fsf@telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07 Mar 2005 22:29:26 +0100, Peter Osterlund <petero2@telia.com> wrote:
> Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:
> > Still I think having Synaptics driver installed is the best way in the
> > end simply because it has a lot of knobs so one can adjust tpouchpad's
> > behavior to his/her liking. Maybe once distibutions start packaging
> > and activating it by default it will be less of an issue.
> 
> Fedora Core 3 already does that if I remember correctly.
> 

It does have synaptics driver packaged but if I remember correctly it
is not automatically selected during installation.

-- 
Dmitry
