Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129742AbRALHnb>; Fri, 12 Jan 2001 02:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129774AbRALHnW>; Fri, 12 Jan 2001 02:43:22 -0500
Received: from gate.in-addr.de ([212.8.193.158]:49928 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S129742AbRALHnF>;
	Fri, 12 Jan 2001 02:43:05 -0500
Date: Fri, 12 Jan 2001 08:42:59 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Christoph Lameter <christoph@lameter.com>
Cc: khttpd-users@zgp.org, linux-kernel@vger.kernel.org
Subject: Re: khttpd beaten by boa
Message-ID: <20010112084259.B441@marowsky-bree.de>
In-Reply-To: <Pine.LNX.4.21.0101071655090.1110-100000@home.lameter.com> <Pine.LNX.4.21.0101112214040.22231-100000@home.lameter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.3i
In-Reply-To: <Pine.LNX.4.21.0101112214040.22231-100000@home.lameter.com>; from "Christoph Lameter" on 2001-01-11T22:20:56
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2001-01-11T22:20:56,
   Christoph Lameter <christoph@lameter.com> said:

> Then we decided to switch persistant connection off... But boa still wins.
> 
> What is wrong here? I would expect transferates of a 3-4 megabytes over a
> localhost interface. The file is certainly in some kind of cache.

This just goes on to show that khttpd is unnecessary kernel bloat and can be
"just as well" handled by a userspace application, minus some rather very
special cases which do not justify its inclusion into the main kernel.

Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Perfection is our goal, excellence will be tolerated. -- J. Yahl

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
