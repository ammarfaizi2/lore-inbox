Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266661AbUGKUtd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266661AbUGKUtd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 16:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266662AbUGKUtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 16:49:33 -0400
Received: from [80.72.36.106] ([80.72.36.106]:58800 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S266661AbUGKUtc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 16:49:32 -0400
Date: Sun, 11 Jul 2004 22:49:27 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VESA fb problem with 2.6.7-mm[567]
In-Reply-To: <20040711203659.GE2899@charite.de>
Message-ID: <Pine.LNX.4.58.0407112245580.8681@alpha.polcom.net>
References: <20040711203659.GE2899@charite.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Jul 2004, Ralf Hildebrandt wrote:

> The nvidia graphics card in one of my laptops cannot be talked into
> working with vesafb:

Maybe try vesafb-tng at http://dev.gentoo.org/~spock/ .
This is completly rewritten, better and more correct implementation with 
maany new features. See docs.

It is working for me with nvidia binary drivers for X and vesafb-tng for 
console.

Please report your success / failure to spock.


Grzegorz Kulewski

