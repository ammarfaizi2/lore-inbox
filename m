Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRBWOMV>; Fri, 23 Feb 2001 09:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129066AbRBWOMK>; Fri, 23 Feb 2001 09:12:10 -0500
Received: from atlantis.hlfl.org ([213.41.91.231]:29703 "HELO
	atlantis.hlfl.org") by vger.kernel.org with SMTP id <S129051AbRBWOMF>;
	Fri, 23 Feb 2001 09:12:05 -0500
Date: Fri, 23 Feb 2001 15:12:04 +0100
From: "Arnaud S . Launay" <asl@launay.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: OOPS with 2.4.2-ac2
Message-ID: <20010223151204.A28383@profile4u.com>
Mail-Followup-To: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20010223144745.A28278@profile4u.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010223144745.A28278@profile4u.com>; from asl@launay.org on Fri, Feb 23, 2001 at 02:47:45PM +0100
X-PGP-Key: http://launay.org/pgpkey.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Fri, Feb 23, 2001 at 02:47:45PM +0100, Arnaud S . Launay a écrit:
> I'm experimenting a 100% reproducable oops, ksymoops filtered
> below, when trying to connect via ssh to the 2.4.2-ac2 machine.
> (openssh 2.1.1p1)

uhuh -- just seen I'm using a gcc snapshot of today. this should
explain. (funny to see "3.1" when asking gcc --version).

Anyway, latest gcc seems to broke kernel once again.

Arnaud.
