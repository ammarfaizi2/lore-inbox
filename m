Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288611AbSBKL7b>; Mon, 11 Feb 2002 06:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288614AbSBKL7V>; Mon, 11 Feb 2002 06:59:21 -0500
Received: from grisu.bik-gmbh.de ([194.233.237.82]:24337 "EHLO
	grisu.bik-gmbh.de") by vger.kernel.org with ESMTP
	id <S288611AbSBKL7I>; Mon, 11 Feb 2002 06:59:08 -0500
Date: Mon, 11 Feb 2002 12:59:36 +0100
From: Florian Hars <florian@hars.de>
To: Heinz Diehl <hd@cavy.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Disk-I/O and kupdated@99.9% system (2.4.18-pre9)
Message-ID: <20020211115936.GA377@bik-gmbh.de>
In-Reply-To: <20020208164250.GA321@bik-gmbh.de> <20020210115509.GA493@chiara.cavy.de> <20020211115527.GA336@bik-gmbh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020211115527.GA336@bik-gmbh.de>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Soyy, I just hit the wrong key before pasting in the numbers, so
here they are:

> On a plain ext2-filesystem on a primary partition I get (with -mjc):
# time tar -xzf linux-2.4.17.tar.gz; time sync

real    0m18.818s
user    0m1.890s
sys     0m14.740s

real    0m21.990s
user    0m0.000s
sys     0m11.320s

Yours, Florian Hars.
