Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265162AbUAEPXg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 10:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265161AbUAEPXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 10:23:35 -0500
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:10689 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S265162AbUAEPWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 10:22:52 -0500
Date: Mon, 5 Jan 2004 16:22:48 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Amit Gurdasani <amitg@alumni.cmu.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Pentium M config option for 2.6
In-Reply-To: <Pine.LNX.4.56.0401051858540.4783@athena.localdomain>
Message-ID: <Pine.LNX.4.53.0401051621160.3660@gockel.physik3.uni-rostock.de>
References: <Pine.LNX.4.56.0401051858540.4783@athena.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jan 2004, Amit Gurdasani wrote:

> Perhaps -mcpu=pentium3 -march=pentium4 would be a good compromise? From the
> GCC 3.3 info pages:
[...]
>      for CPU-TYPE are the same as for `-mcpu'.  Moreover, specifying
>      `-march=CPU-TYPE' implies `-mcpu=CPU-TYPE'.

... thus leaving the "-mcpu=pentium3" without effect.

Tim
