Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266188AbUANM72 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 07:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266271AbUANM72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 07:59:28 -0500
Received: from intra.cyclades.com ([64.186.161.6]:6553 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S266188AbUANM70
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 07:59:26 -0500
Date: Wed, 14 Jan 2004 10:55:09 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@Stimpy.netroedge.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [PATCH 2.4] i2c cleanups, third wave
In-Reply-To: <20040111144214.7a6a4e59.khali@linux-fr.org>
Message-ID: <Pine.LNX.4.58L.0401141052590.6737@logos.cnet>
References: <20040111144214.7a6a4e59.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 11 Jan 2004, Jean Delvare wrote:

> I will be sending 8 patches to you, based on linux-2.4.25-pre4. They
> contain cleanups for the i2c subsystem code, ported from LM Sensors' i2c
> CVS repository [1]. Since that repository was also the base of the i2c
> subsystem as is now in linux 2.6, one might also consider these patches
> as backports from linux 2.6.
>
> Details about what the patch does and credits will be found with each
> patch.

Jean,

>From what I understand all patches are cleanups except the bus scanning
removal (which fixes a problem on ThinkPad?).

I want to merge only bug fixes or practical corrections.

Please correct me if I overlooked the patches and they contain bug fixes.
