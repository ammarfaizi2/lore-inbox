Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271995AbRJEUXI>; Fri, 5 Oct 2001 16:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271906AbRJEUWt>; Fri, 5 Oct 2001 16:22:49 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:56334 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S271987AbRJEUWk>; Fri, 5 Oct 2001 16:22:40 -0400
Date: Fri, 5 Oct 2001 17:22:40 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Seth Mos <knuffie@xs4all.nl>
Cc: Krzysztof Rusocki <kszysiu@main.braxis.co.uk>, <linux-xfs@oss.sgi.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: %u-order allocation failed
In-Reply-To: <Pine.BSI.4.10.10110052208390.303-100000@xs3.xs4all.nl>
Message-ID: <Pine.LNX.4.33L.0110051721550.26495-100000@duckman.distro.conectiva>
X-supervisor: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Oct 2001, Seth Mos wrote:

> This happens using either 2.4.10-xfs or 2.4.11-pre3-xfs.

Ohh duh, IIRC there are a bunch of highmem bugs in
-linus which are fixed in -ac.

Can you reproduce the bug with an -ac kernel ?

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/  (volunteers needed)

http://www.surriel.com/		http://distro.conectiva.com/

