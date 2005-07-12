Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261303AbVGLKip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbVGLKip (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 06:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbVGLKip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 06:38:45 -0400
Received: from spc2-brig1-3-0-cust232.asfd.broadband.ntl.com ([82.1.142.232]:5059
	"EHLO ppgpenguin.kenmoffat.uklinux.net") by vger.kernel.org with ESMTP
	id S261303AbVGLKhO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 06:37:14 -0400
Date: Tue, 12 Jul 2005 11:37:12 +0100 (BST)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: Eric Piel <Eric.Piel@lifl.fr>
Cc: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
Subject: Re: ondemand cpufreq ineffective in 2.6.12 ?
In-Reply-To: <42D3782F.7070104@lifl.fr>
Message-ID: <Pine.LNX.4.58.0507121131001.7702@ppg_penguin.kenmoffat.uklinux.net>
References: <Pine.LNX.4.58.0507111702410.2222@ppg_penguin.kenmoffat.uklinux.net>
 <Pine.LNX.4.58.0507112044001.3450@ppg_penguin.kenmoffat.uklinux.net>
 <200507120755.03110.kernel@kolivas.org> <42D3782F.7070104@lifl.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2005, Eric Piel wrote:

> It's a tradeoff :-)
>
> Ken, does this solve your problems (but that seems strange that all your
> tasks are nice'd) ?
>
> Eric
>

 I was going to say that niceness didn't affect what I was doing, but
I've just rerun it [ in 2.6.11.9 ] and I see that tar and bzip2 show up
with a niceness of 10.  I'm starting to feel a bit out of my depth here
...

Ken
-- 
 das eine Mal als Tragödie, das andere Mal als Farce

