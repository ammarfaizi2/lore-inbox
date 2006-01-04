Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbWADQW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbWADQW6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 11:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbWADQW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 11:22:58 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:18229 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932213AbWADQW5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 11:22:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iYKXaCDL/P0ivzeOsViKpG23KioSdvPGX5B1mExKD4BPA536gEpAmY+u2hdWdWeKNJKy3LNXC/3WPfAU55Ijqx1FJ1Jgr+3XdRK4nQWlXLoltt5OqhAdDZ/V8sIwP8tK55d2srFavu/BPmw94NLb2GyZXS3yr2hJIZMw2jG3RvY=
Message-ID: <d120d5000601040822p5d15880bu51e5989917389e4@mail.gmail.com>
Date: Wed, 4 Jan 2006 11:22:56 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Scott A Crosby <scrosby@cs.rice.edu>
Subject: Re: tap-drag on laptop touchpad no longer works in 2.6.15 and 2.6.13
Cc: petero2@telia.com, Vojtech Pavlik <vojtech@ucw.cz>,
       linux-kernel@vger.kernel.org
In-Reply-To: <oydd5j80ybv.fsf@cs.rice.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <oydd5j80ybv.fsf@cs.rice.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/06, Scott A Crosby <scrosby@cs.rice.edu> wrote:
> I'm not sure if it was a planned change, but the default behavior for
> my touchpad has changed --- I can no longer tap-drag.
>

Please try installing synaptics X driver:

            http://web.telia.com/~u89404340/touchpad/

or use "psmouse.proto=exps" option to restore old behavior.

--
Dmitry
