Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261578AbULVCYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261578AbULVCYy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 21:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbULVCYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 21:24:54 -0500
Received: from rproxy.gmail.com ([64.233.170.199]:49944 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261578AbULVCYx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 21:24:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=YbtP8mEF1MBsCqvlEqRzj24VroSeCKq+FR8M9RIqcp80OfKkjkobfSbJgeApI+v/JIsuTB+c9MdvHWT/fTI/wr3dUzhzGgPx1Lks2bsXkYen4/2p6RTil/gb5a7Ld4elXPeKta4chYCQmFNVzW2GIgVy4Wiql8PYoH04N9N3r0U=
Message-ID: <cce9e37e041221182413ed12aa@mail.gmail.com>
Date: Wed, 22 Dec 2004 02:24:52 +0000
From: Phil Lougher <phil.lougher@gmail.com>
Reply-To: Phil Lougher <phil.lougher@gmail.com>
To: Brad Fitzpatrick <brad@danga.com>
Subject: Re: Make changes to read-only file system using RAM
Cc: Chris Swanson <chrisjswanson@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0412211015030.17405@danga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1bdcbebf04122110087de9d976@mail.gmail.com>
	 <Pine.LNX.4.58.0412211015030.17405@danga.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Dec 2004 10:15:41 -0800 (PST), Brad Fitzpatrick
<brad@danga.com> wrote:
> Chris,
> 
> Check out unionfs.

You could try 'mini_fo'.  This is similar to unionfs and it is already
used on a number of liveCDs.  Documentation
http://www.denx.de/PDF/Diplomabeit-MK-1.0-net.pdf, software
ftp://ftp.denx.de/pub/mini_fo.

Unfortunately it also only works on 2.4.

Phillip
