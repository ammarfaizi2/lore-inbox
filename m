Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263088AbTKYUyb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 15:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263101AbTKYUyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 15:54:31 -0500
Received: from sweetums.bluetronic.net ([24.199.150.42]:13455 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S263088AbTKYUya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 15:54:30 -0500
Date: Tue, 25 Nov 2003 15:52:11 -0500 (EST)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Nick <nick@snowman.net>
cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: Copy protection of the floppies
In-Reply-To: <Pine.LNX.4.21.0311251336250.24128-100000@ns.snowman.net>
Message-ID: <Pine.GSO.4.33.0311251548030.13188-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Nov 2003, Nick wrote:
>Hardware dongles.  You need to be a bit creative but it can be done.  Say
>on save of the file output it to the hardware dongle with encrypts it with
>your private key, then on load of the file it gets decrypted with the
>public key, which is available, or some similar scheme.

SOFTWARE still has to talk to the dongle.  SOFTWARE can be CHANGED.  Go
talk to the guys at autocad... it's trivial to find TSRs to emulate
the dongle and patches to out-right do away with it.

--Ricky


